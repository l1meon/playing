module ApplicationHelper
include GameEngine

  def all_who_bet
    $redis.zrange('table_bet_1_3_players_nr_13', 0, -1)
  end

  def all_users
    $redis.keys('*@*')
  end

  def info_test
    @is_winner ||= {}
    for i in 0..3 do
      @redis_count = $redis.zcount('table_bet_1_3_players_nr_13', i, i)
      if @redis_count == 1
        @table_winner = $redis.zrangebyscore('table_bet_1_3_players_nr_13', i, i)
        @number_winner = $redis.zscore('table_bet_1_3_players_nr_13', @table_winner)
        @is_winner = { 'number' => @number_winner.to_i, 'user' => @table_winner.join(' ')}
      end
    end
    unless @is_winner.empty?
      %(
    The winner number: #{@is_winner['number']}
      \n
    The winner player: #{@is_winner['user']}
      )
    end
  end

end
