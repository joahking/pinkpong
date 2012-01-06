require 'machinist/active_record'

Game.blueprint do
  player_left  { User.make }
  player_right { User.make }
  winner       { User.make }
end

User.blueprint do
  email    { "user-#{sn}@pinkpong.com" }
  password { "password" }
end
