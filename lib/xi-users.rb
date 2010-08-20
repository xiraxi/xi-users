
class XiUsersPlugin < Rails::Engine
  config.xi_users = ActiveSupport::OrderedOptions.new

  config.xi_users.recaptcha = ActiveSupport::OrderedOptions.new
  config.xi_users.recaptcha.public_key = "6LcqTwEAAAAAAGnnW3NyEMwiDXT9cuPwbgoDVDhr"
  config.xi_users.recaptcha.private_key = "6LcqTwEAAAAAAKmdyQPEqlBwhZZhstJ4hMwZQq56"

  config.xi_users.icon_size = ActiveSupport::OrderedOptions.new
  config.xi_users.icon_size.big = "90x90"
  config.xi_users.icon_size.thumb = "36x36"

  config.xi_users.icons = ActiveSupport::OrderedOptions.new
  config.xi_users.icons.male = ActiveSupport::OrderedOptions.new
  config.xi_users.icons.male.big = "icons/male_big_icon.gif" 
  config.xi_users.icons.male.thumb = "icons/male_thumb_icon.gif"
  config.xi_users.icons.female = ActiveSupport::OrderedOptions.new
  config.xi_users.icons.female.big = "icons/female_big_icon.gif"
  config.xi_users.icons.female.thumb = "icons/female_thumb_icon.gif"
end
