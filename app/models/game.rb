class NonRepeatedPlayersValidator < ActiveModel::Validator
  def validate(record)
    users_id = [record.winner_id, record.loser_id,
                record.winner_double_id, record.loser_double_id]
    users_id.compact! # only users, not nils

    if users_id.uniq != users_id
      record.errors[:base] << 'Repeated player'
    end
  end
end

class PlayersParityValidator < ActiveModel::Validator
  def validate(record)
    users_id = [record.winner_id, record.loser_id,
                record.winner_double_id, record.loser_double_id]
    users_id.compact! # only users, not nils

    if users_id.length != 2 && users_id.length != 4
      record.errors[:base] << 'Wrong number of players'
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
  validates_with PlayersParityValidator

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
