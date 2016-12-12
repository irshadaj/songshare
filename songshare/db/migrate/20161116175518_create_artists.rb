class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :external_id, null: false, unique: true
      t.string :name
      t.string :genres, array: true

      t.timestamps
    end
  end
end
