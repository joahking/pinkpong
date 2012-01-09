require 'machinist/active_record'

Game.blueprint do
  winner { User.make! }
  loser  { User.make! }
end

User.blueprint do
  email    { "user-#{sn}@pinkpong.com" }
  password { "password" }
end
