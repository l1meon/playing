class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :win_size
      t.integer :table_id

      t.timestamps null: false
    end
    add_index :games, :user_id
    add_index :games, :table_id
  end
end
