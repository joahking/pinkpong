class SimplifyColumnsInGames < ActiveRecord::Migration
  def up
    remove_column :games, :player_left_id
    remove_column :games, :player_right_id

    add_column :games, :loser_id, :integer
    add_index :games, :loser_id
  end

  def down
    add_column :games, :player_left_id, :integer
    add_column :games, :player_right_id, :integer

    add_index :games, :player_left_id
    add_index :games, :player_right_id

    remove_column :games, :loser_id
  end
end
