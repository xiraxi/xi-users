class UserSessionsController < ApplicationController

  def new
    if current_user
      redirect_to user_profile_path
      return
    end

    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t("session.login.welcome_back")
      redirect_to user_profile_path
    else
      flash.now[:error] = t("session.login.invalid")
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url
  end

end
