class Table < ActiveRecord::Base
  has_many :table_games
  has_many :users, through: :table_games

  validates :connected_players, numericality: { :only_integer => true, :less_than_or_equal_to => 3}, on: [:update]

end
