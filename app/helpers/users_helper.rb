module UsersHelper

  def link_to_profile(user, options = {})
    link_to(user.complete_name, user_path(user), { :class => "user_name" }.merge(options))
  end

  def user_photo(user, options = {})
    size = options[:big] ? Rails.application.config.xi_users.icon_size.big : Rails.application.config.xi_users.icon_size.thumb
    user_name = user.complete_name
    img_opts = options[:img_opts] || {}
    if photo = user.photo
       type = (options[:big] ? nil : :thumb)
       html_img = image_tag(photo.url(:thumb), img_opts.merge(:size => size, :title => user_name, :alt => user_name))
    else
       gender = user.gender || "male"
       html_img = image_tag(options[:big] ? Rails.application.config.xi_users.icons.send(gender).big : Rails.application.config.xi_users.icons.send(gender).thumb , img_opts.merge(:size => size, :title => user_name, :alt => user_name))
    end

    link = options[:link]
    if link == false
      html_img
    else
      link_to(html_img, link || user_path(user), options[:link_opts])
    end 
  end
end
