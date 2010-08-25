class UsersController < ApplicationController

  def new
    redirect_to user_profile_path if current_user
    @user = User.new
  end

  def create
    if attributes = XiraxiCore::Security.decrypt(params[:validated_attributes])
      @user = User.new(attributes)
      @user.email = attributes[:email]
      if verify_recaptcha(:private_key => Rails.application.config.xi_users.recaptcha.private_key, :model => @user) and @user.save
        render :create_success
      else
        @validated_attributes = params[:validated_attributes]
        render :action => "recaptcha"
      end
    else
      @user = User.new(params[:user])
      @user.email = params[:user][:email]
      if @user.valid?
        @validated_attributes = XiraxiCore::Security.encrypt(params[:user])
        render :recaptcha
      else
        render :new
      end
    end
  end

  def validate_account
    if current_user
      redirect_to user_profile_path 
      return
    end

    @user = User.find_using_perishable_token(params[:id])
    if @user
      @user.confirmed_at = Time.now
      @user.save!

      flash[:notice] = I18n.t("users.validate_account.success")
      redirect_to login_path
    else
      not_found
    end
  end

  only_logged :settings
  def settings
    @user = current_user
    if request.post?
      # Security on attribute attacks relies on the model
      @user.attributes = params[:user]
      if @user.save!
        flash[:notice] = I18n.t("account_settings.notice_saved")
        redirect_to user_profile_path
      end
    end
  end

  only_logged :settings
  def email
    @user = current_user
    if request.post?
      # Security on attribute attacks relies on the model
      @user.email = params[:user][:email]
      if @user.valid?
        User::ChangeEmailRequest.create! :user => @user, :new_email => @user.email

        flash[:notice] = I18n.t("users.change_email.notice_saved")
        redirect_to user_profile_path
      end
    end
  end

  def index
    dataset = User.confirmed

    dataset = case params[:order]
      when "last_login" then
        dataset.order("current_login_at DESC")
      when "connected" then
        dataset.order("current_login_at DESC").where(["current_login_at > ?", (params[:within] || 30).to_i.minutes.ago])
      else
        dataset.order("confirmed_at DESC")
    end

    @users = dataset.paginate(:page => params[:page], :per_page => 10)
  end

  def validate_email
    change_request = User::ChangeEmailRequest.find_by_key(params[:id])
    return not_found if change_request.blank?

    if change_request.validate_email
      flash[:notice] = I18n.t("users.change_email.validated", :email => change_request.user.email)
      change_request.destroy
    else
      flash[:error] = I18n.t("users.change_email.not_validated")
    end

    if current_user.nil?
      redirect_to login_path
    else
      redirect_to user_profile_path
    end
  end

  only_logged :settings
  def change_password
    if request.post? and params[:user].kind_of?(Hash)
      @user = current_user
      @user.current_password = params[:user][:current_password]
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        flash[:notice] = I18n.t("users.change_password.updated")
        redirect_to user_profile_path
      end
    end
  end

  def request_reset_password
    if current_user
      redirect_to user_profile_path
    end

    if request.post?
      if user = User.find_by_email(params[:email])
        @reset_request = User::ResetPasswordRequest.new
        @reset_request.user = user
        @reset_request.save!
      else
        flash.now[:error] = t("users.reset_password.unknown_email")
      end
    end
  end

  def reset_password
    @reset_password_request = User::ResetPasswordRequest.find_by_key(params[:id])
    return not_found unless @reset_password_request

    if request.post?
      @user = @reset_password_request.user
      @user.password = params[:user][:password_confirmation]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        # Authlogic creates a new session when saves the user
        flash[:notice] = t("users.reset_password.password_updated")
        redirect_to login_path
      end
    end
  end

  def home
    if current_user.nil?
      redirect_to login_path
      return
    end

    @user = current_user
    render :template => "users/profile"
  end

  def show
    begin
      @user = User.confirmed.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return not_found
    end
    render :template => "users/profile"
  end

end
