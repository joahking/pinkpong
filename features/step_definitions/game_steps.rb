When /^I create a game$/ do
  User.make! :email => "aurelian@pinkpong.com"
  User.make! :email => "raimon@pinkpong.com"

  visit root_path
  click_link "New Game"

  select "raimon@pinkpong.com", :from => "Winner"
  select "aurelian@pinkpong.com", :from => "Loser"

  click_button "Create Game"
end

When /^I create a game using emails$/ do
  visit root_path
  click_link "New Game"

  fill_in "winner_email",  :with => "aurelian@pinkpong.com"
  fill_in "loser_email", :with => "raimon@pinkpong.com"

  click_button "Create Game"
end

Then /^I should see the game$/ do
  assert has_content?("Game was successfully created")
end

Then /^the players should receive a game email$/ do
  step %{"#{Game.last.winner.email}" should receive an email with subject "You won a pinkpong game"}
  step %{"#{Game.last.loser.email}" should receive an email with subject "You lost a pinkpong game"}
end
