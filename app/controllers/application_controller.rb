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

  def session_admin?
    current_user and current_user.admin?
  end

  # Security logic

  class_inheritable_hash :_actions_to_be_validated

  def _validate_user_by_action
    return if _actions_to_be_validated.blank?

    rule = _actions_to_be_validated["*"] || _actions_to_be_validated[action_name]
    return if rule.blank?

    if [:admin, :logged].include?(rule)
      if current_user.nil?
        redirect_to login_path
        return
      end

      if rule == :admin
        if not current_user.admin?
          forbidden
        end
      end
    end

  end

  before_filter :_validate_user_by_action

  class <<self
    def _register_validated_action(rule, actions)
      self._actions_to_be_validated ||= {}
      actions = ["*"] if actions.empty?

      actions.each do |action|
        _actions_to_be_validated[action.to_s] = rule
      end
    end

    def only_admins(*actions)
      _register_validated_action :admin, actions
    end

    def only_logged(*actions)
      _register_validated_action :logged, actions
    end
  end

end
