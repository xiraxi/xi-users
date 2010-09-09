class User::ValidationPendingUsersController < ApplicationController

  admin_section

  include ::BasicCrud::Controller

  def valid_actions
    [:list]
  end

  def action_links
    [:validate]
  end

  def columns
    [
        { :name => :email },
        { :name => :name },
        { :name => :surname },
        { :name => :created_at },
    ]
  end

  def model
    User
  end

  def records
    User.where("confirmed_at IS NULL AND deleted_at IS NULL").order("created_at").paginate(:page => params[:page], :per_page => 20)
  end

  def crud_name
    t("validation_pending_users.title")
  end

  def validate
    @user = User.find_using_perishable_token(params[:id])
    if @user
      @user.confirmed_at = Time.now
      @user.save!

      flash[:notice] = I18n.t("users.validate_account.success")
      redirect_to user_validation_pending_users_path
    else
      not_found
    end
  end

end
