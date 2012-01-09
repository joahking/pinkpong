require 'test_helper'

class GameTest < ActiveSupport::TestCase
  should belong_to :winner
  should belong_to :loser

  should validate_presence_of :winner
  should validate_presence_of :loser

  should 'validate players parity' do
    game = Game.new :winner => User.make!, :winner_double => User.make!, :loser => User.make!

    assert !game.valid?
    assert game.errors[:winner_double]
  end

  should 'validate winner_double is an existing player' do
    game = Game.new :winner => User.make!, :winner_double_id => 0

    assert !game.valid?
    assert game.errors[:winner_double]
  end

  should 'validate loser_double is an existing player' do
    game = Game.new :winner => User.make!, :loser_double_id => 0

    assert !game.valid?
    assert game.errors[:loser_double]
  end

  should 'not allow repeated players in single' do
    same_player = User.make!

    game = Game.new :winner => same_player, :loser => same_player

    assert !game.valid?
    assert game.errors[:base]
  end

  should 'not allow repeated players in doubles' do
    same_player = User.make!
    player2 = User.make!
    player3 = User.make!

    winners_repeated = Game.new :winner => same_player, :winner_double => same_player, :loser => player2, :loser_double => player3
    assert !winners_repeated.valid?
    #assert winners_repeated.errors[:winner_double]

    loser_repeated = Game.new :winner => same_player, :winner_double => player2, :loser => same_player, :loser_double => player3
    assert !loser_repeated.valid?
    #assert loser_repeated.errors[:loser]

    loser_double_repeated = Game.new :winner => same_player, :winner_double => player2, :loser => player3, :loser_double => same_player
    assert !loser_double_repeated.valid?
    #assert loser_double_repeated.errors[:loser_double]

    loser_repeated = Game.new :winner => player2, :winner_double => same_player, :loser => same_player, :loser_double => player3
    assert !loser_repeated.valid?
    #assert loser_repeated.errors[:loser]

    loser_double_repeated = Game.new :winner => player2, :winner_double => same_player, :loser => player3, :loser_double => same_player
    assert !loser_double_repeated.valid?
    #assert loser_double_repeated.errors[:loser_double_repeated]

    losers_repeated = Game.new :winner => player2, :winner_double => player3, :loser => same_player, :loser_double => same_player
    assert !losers_repeated.valid?
    #assert losers_repeated.errors[:loser_double]
  end

end
