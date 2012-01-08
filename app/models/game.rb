class NonRepeatedPlayersValidator < ActiveModel::Validator
  def validate(record)
    if record.winner == record.loser
      record.errors[:loser] << 'Repeated player'
    end
  end
end

class Game < ActiveRecord::Base
  belongs_to :winner, :class_name => "User"
  belongs_to :winner_double, :class_name => "User"

  belongs_to :loser, :class_name => "User"
  belongs_to :loser_double, :class_name => "User"

  validates :winner, :presence => true
  validates :loser, :presence => true

  validates_with NonRepeatedPlayersValidator

  after_create :email_players

  def single?
    winner_double.nil? && loser_double.nil?
  end

  def double?
    !single?
  end

  protected

  def email_players
    if single?
      PlayerMailer.win_email(winner, self).deliver
      PlayerMailer.lose_email(loser, self).deliver
    else
      PlayerMailer.double_win_email(winner, self).deliver
      PlayerMailer.double_win_email(winner_double, self).deliver

      PlayerMailer.double_lose_email(loser, self).deliver
      PlayerMailer.double_lose_email(loser_double, self).deliver
    end
  end
end
