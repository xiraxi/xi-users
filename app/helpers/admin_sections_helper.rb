module AdminSectionsHelper

  def render_admin_menu
    route_groups = {}
    Rails.application.routes.routes. \
      find_all {|route| route.path =~ %r[^/admin/] && route.defaults[:action] == "index" && route.name != "admin_index" }. \
      each do |route|
        if route.path =~ %r[/admin/(\w+)/\w+]
          route_groups[$1] ||= []
          route_groups[$1] << route
        end
      end

    content_tag :div, :class => "admin_menu" do
      route_groups.each_pair do |group_name, items|
        concat content_tag(:h2, t("admin_index.groups.#{group_name}"))

        items.each do |item|
          concat(content_tag :ul do
            concat content_tag(:li, link_to(t("admin_index.items.#{item.name}"), send(item.name + "_path")))
          end)
        end
      end
    end
  end

end
