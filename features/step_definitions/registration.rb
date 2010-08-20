
Then /^the password for "([^"]*)" is "([^"]*)"$/ do |user_email, user_password|
  User.find_by_email(user_email).valid_password?(user_password).should be_true
end
