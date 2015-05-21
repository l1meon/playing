module ApplicationHelper
include GameEngine

  def all_who_bet
    $redis.zrange('users', 0, -1)
  end

  def all_users
    $redis.keys
  end
end
