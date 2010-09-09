class AdminController < ApplicationController

  only_admins

  def index
    @route_groups = {}
    Rails.application.routes.routes. \
      find_all {|route| route.path =~ %r[^/admin/] && route.defaults[:action] == "index" && route.name != "admin_index" }. \
      each do |route|
        if route.path =~ %r[/admin/(\w+)/\w+]
          @route_groups[$1] ||= []
          @route_groups[$1] << route
        end
      end
  end

end
