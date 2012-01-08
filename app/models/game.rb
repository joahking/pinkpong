class NonRepeatedPlayersValidator < ActiveModel::Validator
  def validate(record)
    if record.winner == record.loser
      record.errors[:loser] << 'Repeated player'
    end
  end
end

class Game < ActiveRecord::Base
  belongs_to :winner, :class_name => "User"
  belongs_to :loser, :class_name => "User"

  validates :winner, :presence => true
  validates :loser, :presence => true
  validates_with NonRepeatedPlayersValidator

  after_create :email_players

  protected

  def email_players
    PlayerMailer.win_email(winner, self).deliver
    PlayerMailer.lose_email(loser, self).deliver
  end
end
