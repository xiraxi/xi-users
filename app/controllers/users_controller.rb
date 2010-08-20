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
        redirect_to user_profile_path
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
    @users = User.valid
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

  def home
    if current_user.nil?
      redirect_to login_path
    end
  end

end
