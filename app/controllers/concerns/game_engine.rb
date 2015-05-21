module GameEngine
  extend ActiveSupport::Concern
  attr_accessor :winners, :users

  def users_array
    @users ||= []
  end

  def winners_array
    @win_arry ||= []
  end
  def add_user_to_game(user_email, number)
    users_array << user_email
    unless users_array.empty?
      $redis.zadd('users', number, user_email)
    end
  end

  def repartize_users(number)
    for i in number do
      $redis.zrangebyscore('users', i, 1)
      winners_array << user_email
    end
  end
  def who_win
    @winners ||= []
    @winners << $redis.zrangebyscore('users', 1, 1)
    @winners
  end
end