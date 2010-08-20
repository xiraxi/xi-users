class User::Notifier < ActionMailer::Base
  default :from => Rails.application.config.community.default_from

  # Subject is set in t("user.notifier.change_email.subject")
  def change_email(change_email_request)
    @change_email_request = change_email_request
    mail :to => change_email_request.new_email
  end

  def signup
  end

  def forgot_password
  end
end
