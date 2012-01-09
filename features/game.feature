Feature: Game feature

Scenario: Create game requires login
  Given I am not authenticated
  When I visit the new game page
  Then I should be requested to login

Scenario: Create game with existing users
  Given I am a new, authenticated user
  When I create a game
  Then I should see the game
  And the players should receive a game email

Scenario: Create game using emails
  Given I am a new, authenticated user
  When I create a game using emails
  Then I should see the game
  And the players should receive a game email

Scenario: Create double with existing users
  Given I am a new, authenticated user
  When I create a double
  Then I should see the game
  And the players should receive a double email

Scenario: Create double using emails
  Given I am a new, authenticated user
  When I create a double using emails
  Then I should see the game
  And the players should receive a double email
