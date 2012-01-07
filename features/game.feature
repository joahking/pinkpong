Feature: Game feature

Scenario: Create game with existing users
  When I create a game
  Then I should see the game
  And the players should receive a game email

Scenario: Create game using emails
  When I create a game using emails
  Then I should see the game
  And the players should receive a game email
