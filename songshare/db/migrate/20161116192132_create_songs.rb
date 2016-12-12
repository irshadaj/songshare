class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :external_id, null: false, index: true
      t.string :title
      t.integer :disc_number, default: 1
      t.integer :track_number
      t.boolean :explicit
      t.integer :duration
      t.references :album

      t.timestamps
    end

    add_foreign_key :songs, :albums
    add_index :songs, [:album_id, :disc_number, :track_number]
  end
end
