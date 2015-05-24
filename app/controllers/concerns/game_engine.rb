module GameEngine
  extend ActiveSupport::Concern
  attr_accessor :winners, :users


  def add_user_to_game(user_email, number, table_name)
    $redis.zadd("table_bet_1_3_players_nr_#{table_name}", number.to_i, user_email)
    case number.to_i
      when 1
        $redis.incr('nr_1')
      when 2
        $redis.incr('nr_2')
      when 3
        $redis.incr('nr_3')
      else
        flash[:notice] = 'Error'
    end
  end

  def repartize_users(number)
    for i in number do
      $redis.zrangebyscore('users', i, 1)
    end
  end
  def who_win
    @winners ||= []
    @winners << $redis.zrangebyscore('users', 1, 1)
    @winners
  end
end