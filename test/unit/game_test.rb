require 'test_helper'

class GameTest < ActiveSupport::TestCase
  should belong_to :player_left
  should belong_to :player_right
  should belong_to :winner

  should validate_presence_of :player_left
  should validate_presence_of :player_right
  should validate_presence_of :winner

  # test "the truth" do
  #   assert true
  # end
end
