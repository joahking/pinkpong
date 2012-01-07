class NonRepeatedPlayersValidator < ActiveModel::Validator
  def validate(record)
    if record.player_left == record.player_right
      record.errors[:player_right] << 'Repeated player'
    end
  end
end

class WinnerValidator < ActiveModel::Validator
  def validate(record)
    if [record.player_left, record.player_right].exclude?(record.winner)
      record.errors[:winner] << 'Invalid winner, must be one of the players'
    end
  end
end

class Game < ActiveRecord::Base
  belongs_to :player_left,  :class_name => "User"
  belongs_to :player_right, :class_name => "User"
  belongs_to :winner,       :class_name => "User"

  validates :player_left,  :presence => true
  validates :player_right, :presence => true
  validates :winner,       :presence => true
  validates_with WinnerValidator
  validates_with NonRepeatedPlayersValidator
end
