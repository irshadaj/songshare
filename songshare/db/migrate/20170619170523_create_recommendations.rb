class CreateRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :recommendations do |t|
      t.string :from, null:false
      t.string :to, null:false
      t.string :song, null:false
      t.integer :liked

      t.timestamps
    end
  end
end
