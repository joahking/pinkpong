class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player_left
      t.references :player_right
      t.references :winner
      t.string :score
      t.text :description

      t.timestamps
    end
    add_index :games, :player_left_id
    add_index :games, :player_right_id
    add_index :games, :winner_id
  end
end
