class AddDoubleColumnsToGames < ActiveRecord::Migration
  def change
    add_column :games, :winner_double_id, :integer
    add_index :games, :winner_double_id

    add_column :games, :loser_double_id, :integer
    add_index :games, :loser_double_id
  end
end
