class CreateTableGames < ActiveRecord::Migration
  def change
    create_table :table_games do |t|
      t.integer :table_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :table_games, :table_id
    add_index :table_games, :user_id
  end
end
