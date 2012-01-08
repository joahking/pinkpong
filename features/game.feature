Feature: Game feature

Scenario: Create game with existing users
  When I create a game
  Then I should see the game
  And the players should receive a game email

Scenario: Create game using emails
  When I create a game using emails
  Then I should see the game
  And the players should receive a game email

Scenario: Create double with existing users
  When I create a double
  Then I should see the game
  And the players should receive a double email

Scenario: Create double using emails
  When I create a double using emails
  Then I should see the game
  And the players should receive a double email
