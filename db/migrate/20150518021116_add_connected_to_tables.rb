class AddConnectedToTables < ActiveRecord::Migration
  def change
    add_column :tables, :connected_players, :integer, default: 0
  end
end
