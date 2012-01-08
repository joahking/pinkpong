class PlayerMailer < ActionMailer::Base
  default :from => "app@pinkpong.com"

  def win_email(user, game)
    @user = user
    @game  = game
    mail(:to => user.email, :subject => "You won a pinkpong game")
  end

  def lose_email(user, game)
    @user = user
    @game  = game
    mail(:to => user.email, :subject => "You lost a pinkpong game")
  end

  def double_win_email(user, game)
    @user = user
    @game  = game
    mail(:to => user.email, :subject => "You won a pinkpong double")
  end

  def double_lose_email(user, game)
    @user = user
    @game  = game
    mail(:to => user.email, :subject => "You lost a pinkpong double")
  end

end
