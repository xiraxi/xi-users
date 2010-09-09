class User::AdministratorsController < ApplicationController

  admin_section

  def index
    @admins = User.admins
  end

  def destroy
    admin = User.admins.find(params[:id])
    if admin
      admin.role = User::Role::Regular
      admin.save!
      flash[:notice] = t("administrators.admin_removed")
    else
      flash[:error] = t("administrators.unknown_admin")
    end

    redirect_to user_administrators_path
  end

  def create
    admin = User.find_by_email(params[:new_admin_email])
    if admin
      admin.role = User::Role::Admin
      admin.save!
      flash[:notice] = t("administrators.admin_granted", :email => admin.email)
    else
      flash[:error] = t("administrators.unknown_admin")
    end

    redirect_to user_administrators_path
  end

end
