
if Rails.application.kind_of?(XiUsers::Application)
  XiUsers::Application.config.secret_token = '4b0f98ff8fabe1b5fc5373f2704e767126019f9019af2ce49f359bbc9ab115fa7dd0b612ebf5968d9033456988ade05ff4efe06b68864ad2d6a6a1b286565dec'
  XiUsers::Application.config.session_store :cookie_store, :key => '_xi-users_session'
end
