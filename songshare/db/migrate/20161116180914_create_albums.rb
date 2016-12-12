class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :external_id, null: false, index: true
      t.string :name
      t.integer :year
      t.string :album_type, index: true
      t.string :genres, array: true

      t.timestamps
    end
  end
end
