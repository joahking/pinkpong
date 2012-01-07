class PlayerMailer < ActionMailer::Base
  default :from => "app@pinkpong.com"

  def win_email(user, game)
    @user = user
    @game  = game
    mail(:to => user.email, :subject => "You won a pinkpong game")
  end

end
