class UsersController < ApplicationController

  def new
    redirect_to user_profile_path if current_user
    @user = User.new
  end

  def create
    if attributes = XiraxiCore::Security.decrypt(params[:validated_attributes])
      @user = User.new(attributes)
      if verify_recaptcha(:private_key => Rails.application.config.xi_users.recaptcha.private_key, :model => @user) and @user.save
        redirect_to user_profile_path
      else
        @validated_attributes = params[:validated_attributes]
        render :action => "recaptcha"
      end
    else
      @user = User.new(params[:user])
      if @user.valid?
        @validated_attributes = XiraxiCore::Security.encrypt(params[:user])
        render :action => "recaptcha"
      else
        render :action => "new"
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

end
