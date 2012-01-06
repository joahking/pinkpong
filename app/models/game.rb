class Game < ActiveRecord::Base
  belongs_to :player_left,  :class_name => "User"
  belongs_to :player_right, :class_name => "User"
  belongs_to :winner,       :class_name => "User"

  validates :player_left,  :presence => true
  validates :player_right, :presence => true
  validates :winner,       :presence => true
end
