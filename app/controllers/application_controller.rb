class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user, :session_admin?

  def current_user_session
    return @_current_user_session if defined?(@_current_user_session)
    @_current_user_session = UserSession.find
  end

  def current_user
    return @_current_user if defined?(@_current_user)
    @_current_user = current_user_session && current_user_session.user
  end


  def only_admins_filter
    if current_user.nil?
      redirect_to login_path
      return
    end

    if not current_user.admin?
      forbidden
    end
  end

  def only_logged_filter(*actions)
    if current_user.nil?
      redirect_to login_path
      return
    end
  end

  def session_admin?
    current_user and current_user.admin?
  end

  class <<self
    def only_admins(*actions)
      if actions.empty?
        before_filter :only_admins_filter
      else
        before_filter :only_admins_filter, :only => actions
      end
    end

    def only_logged(*actions)
      if actions.empty?
        before_filter :only_logged_filter
      else
        before_filter :only_logged_filter, :only => actions
      end
    end
  end
end
