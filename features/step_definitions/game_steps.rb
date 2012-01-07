When /^I create a game$/ do
  2.times { User.make }
  visit root_path
  click_link "New Game"
  fill_in "Player left", :with => User.first.id
  fill_in "Player right", :with => User.last.id
  fill_in "Winner", :with => User.last.id
  click_button "Create Game"
end

Then /^I should see the game$/ do
  assert has_content?("Game was successfully created")
end
