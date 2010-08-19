class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def only_admins_filter
    if current_user.nil?
      redirect_to login_path
      return
    end

    if not current_user.admin?
      render :partial => "status/forbidden", :status => 403
    end
  end

  class <<self
    def only_admins(*actions)
      if actions.empty?
        before_filter :only_admins_filter
      else
        before_filter :only_admins_filter, :only => actions
      end
    end
  end
end