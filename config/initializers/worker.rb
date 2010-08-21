
# When XiUsers is loaded as a plugin, the XiUsersWorker::Application constant is not defined, so we do the "worker check" using a string
if Rails.application.class.name == "XiUsersWorker::Application"
  XiUsersWorker::Application.config.secret_token = '4b0f98ff8fabe1b5fc5373f2704e767126019f9019af2ce49f359bbc9ab115fa7dd0b612ebf5968d9033456988ade05ff4efe06b68864ad2d6a6a1b286565dec'
  XiUsersWorker::Application.config.session_store :cookie_store, :key => '_xi-users_session'
end
