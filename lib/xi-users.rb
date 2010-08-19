
class XiUsersPlugin < Rails::Engine
  config.xi_users = ActiveSupport::OrderedOptions.new

  config.xi_users.recaptcha = ActiveSupport::OrderedOptions.new
  config.xi_users.recaptcha.public_key = "6LcqTwEAAAAAAGnnW3NyEMwiDXT9cuPwbgoDVDhr"
  config.xi_users.recaptcha.private_key = "6LcqTwEAAAAAAKmdyQPEqlBwhZZhstJ4hMwZQq56"
end
