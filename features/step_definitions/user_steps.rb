Given /^I am not authenticated$/ do
  # nothing I am not authenticated
  #visit('/users/sign_out') # ensure that at least
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  password = 'secretpass'
  User.make!(:email => email, :password => password, :password_confirmation => password)

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

Then /^I should be requested to login$/ do
  assert_equal current_url, new_user_session_url
end
