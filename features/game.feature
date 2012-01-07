Feature: Game feature

Scenario: Create game
  When I create a game
  Then I should see the game
  And the winner should receive a game email
