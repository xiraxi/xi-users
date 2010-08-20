
Given /^an anonymous session$/ do
  # Nothing to do
end

Given /^a session for the user "([^"]*)"$/ do |user_email|
  user = User.find_by_email(user_email) || Factory(:user, :email => user_email)

  old_password = [user.crypted_password, user.password_salt]
  user.password = user.password_confirmation = "test.pw"
  user.save!

  visit login_path
  page.should have_css("#login-form")
  fill_in("Email", :with => user_email)
  fill_in("Password", :with => "test.pw")
  submit_form("login form")

  # restore password
  user.crypted_password, user.password_salt = old_password
  user.save!
end

Given /^a regular user session$/ do
  user = Factory(:user, :password => "test.pw")
  visit login_path
  page.should have_css("#login-form")
  fill_in("Email", :with => user.email)
  fill_in("Password", :with => "test.pw")
  submit_form("login form")
end

Then /^the current page is the logged user's profile$/ do
  current_path.should eql(user_profile_path)
end

Then /^the session does not have the "([^"]*)" key$/ do |session_key|
  Caulfield.session.should_not include(session_key.tr(" ", "_"))
end

Given /^an admin session$/ do
  user = Factory(:user, :password => "test.pw", :role => User::Role::Admin)
  visit login_path
  page.should have_css("#login-form")
  fill_in("Email", :with => user.email)
  fill_in("Password", :with => "test.pw")
  submit_form("login form")
end

When /^I close the browser$/ do
  # Remove session cookies
  cookie_jar.each do |cookie|
    if cookie.expires.nil?
      cookie_jar.delete cookie.name
    end
  end
end
