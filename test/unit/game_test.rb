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

  should 'not allow repeated players' do
    same_player = User.make!

    game = Game.new :player_left => same_player, :player_right => same_player, :winner => same_player

    assert !game.valid?
    assert game.errors[:player_right]
  end

end
