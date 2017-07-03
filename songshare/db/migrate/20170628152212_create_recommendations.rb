class CreateRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :recommendations do |t|
      t.integer :from, null:false
      t.integer :to, null:false
      t.integer :song_id, null:false
      t.boolean :liked
      t.datetime :created_at, null:false
      t.datetime :updated_at, null:false

      t.timestamps
    end

    add_foreign_key :recommendations, :songs
    add_foreign_key :recommendations, :users, column: :from
    add_foreign_key :recommendations, :users, column: :to
    add_index :recommendations, [:from, :to]
  end
end
