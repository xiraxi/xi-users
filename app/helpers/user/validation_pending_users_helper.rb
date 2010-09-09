module User::ValidationPendingUsersHelper
  def action_link_for_validate(user)
    link_to(t("validation_pending_users.validate.title"), validate_user_validation_pending_user_path(user.perishable_token), :confirm => t("validation_pending_users.validate.confirm", :email => user.email), :method => :post)
  end
end
