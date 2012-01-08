require 'test_helper'

class GameTest < ActiveSupport::TestCase
  should belong_to :winner
  should belong_to :loser

  should validate_presence_of :winner
  should validate_presence_of :loser

  should 'not allow repeated players' do
    same_player = User.make!

    game = Game.new :winner => same_player, :loser => same_player

    assert !game.valid?
    assert game.errors[:loser]
  end
end
