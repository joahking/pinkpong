When /^I visit the homepage$/ do
  visit root_path
end

When /^I visit the new game page$/ do
  visit new_game_path
end

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

When /^I create a double$/ do
  User.make! :email => "aurelian@pinkpong.com"
  User.make! :email => "raimon@pinkpong.com"
  User.make! :email => "jakub@pinkpong.com"
  User.make! :email => "tiago@pinkpong.com"

  visit root_path
  click_link "New Game"

  select "jakub@pinkpong.com", :from => "Winner"
  select "aurelian@pinkpong.com", :from => "Winner double"

  select "raimon@pinkpong.com", :from => "Loser"
  select "tiago@pinkpong.com", :from => "Loser double"

  click_button "Create Game"
end

When /^I create a double using emails$/ do
  User.make! :email => "aurelian@pinkpong.com"
  User.make! :email => "raimon@pinkpong.com"
  User.make! :email => "jakub@pinkpong.com"
  User.make! :email => "tiago@pinkpong.com"

  visit root_path
  click_link "New Game"

  fill_in "winner_email",  :with => "raimon@pinkpong.com"
  fill_in "winner_double_email",  :with => "tiago@pinkpong.com"

  fill_in "loser_email", :with => "jakub@pinkpong.com"
  fill_in "loser_double_email", :with => "aurelian@pinkpong.com"

  click_button "Create Game"
end

Then /^I should see the game$/ do
  assert has_content?("Game was successfully created")
end

Then /^the players should receive a game email$/ do
  step %{"#{Game.last.winner.email}" should receive an email with subject "You won a pinkpong game"}
  step %{"#{Game.last.loser.email}" should receive an email with subject "You lost a pinkpong game"}
end

Then /^the players should receive a double email$/ do
  step %{"#{Game.last.winner.email}" should receive an email with subject "You won a pinkpong double"}
  step %{"#{Game.last.winner_double.email}" should receive an email with subject "You won a pinkpong double"}
  step %{"#{Game.last.loser.email}" should receive an email with subject "You lost a pinkpong double"}
  step %{"#{Game.last.loser_double.email}" should receive an email with subject "You lost a pinkpong double"}
end

Then /^I should see the games$/ do
  assert has_content?("games")
end
