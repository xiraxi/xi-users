
module XiUsers::ControllerHelpers

  def self.included(cls)
    cls.helper_method :current_user_session, :current_user
    cls.extend ClassMethods
  end

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
      forbidden
    end
  end

  def only_logged_filter(*actions)
    if current_user.nil?
      redirect_to login_path
      return
    end
  end

  module ClassMethods
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

class ActionController::Base
  include XiUsers::ControllerHelpers
end
