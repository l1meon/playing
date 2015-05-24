module ApplicationHelper
include GameEngine

  def all_who_bet
    $redis.zrange('table_bet_1_3_players_nr_13', 0, -1)
  end

  def all_users
    $redis.keys('*@*')
  end

  def info_test
    for i in 1..3 do
      @redis_count = $redis.zcount('table_bet_1_3_players_nr_13', i, i)
      if @redis_count == 1
        @number_winner = @redis_count
        @table_winner = $redis.zrangebyscore('table_bet_1_3_players_nr_13', i, i)
      end
    end

    @table_winner
  end
end
