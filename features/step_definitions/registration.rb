
Then /^the password for "([^"]*)" is "([^"]*)"$/ do |user_email, user_password|
  User.find_by_email(user_email).valid_password?(user_password).should be_true
end

When /^I force the reCaptcha to be valid$/ do
  # recaptcha gem skips the validations in test environment
  And "I submit the form"
end

Then /^the user with email "([^"]+)" is confirmed$/ do |user_email|
  User.find_by_email(user_email).confirmed?.should be_true
end
