require 'test_helper'

class GameTest < ActiveSupport::TestCase
  should belong_to :player_left
  should belong_to :player_right
  should belong_to :winner

  should validate_presence_of :player_left
  should validate_presence_of :player_right
  should validate_presence_of :winner

  should 'validate winner is one of the players' do
    player_left = User.make!
    player_right = User.make!
    invalid_winner = User.make!

    game = Game.new :player_left => player_left, :player_right => player_right, :winner => invalid_winner

    assert !game.valid?
    assert game.errors[:winner]
  end
end
