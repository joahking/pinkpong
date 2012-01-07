When /^I create a game$/ do
  User.make! :email => "aurelian@pinkpong.com"
  User.make! :email => "raimon@pinkpong.com"

  visit root_path
  click_link "New Game"

  select "raimon@pinkpong.com", :from => "Player left"
  select "aurelian@pinkpong.com", :from => "Player right"
  select "aurelian@pinkpong.com", :from => "Winner"

  click_button "Create Game"
end

Then /^I should see the game$/ do
  assert has_content?("Game was successfully created")
end
