class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :height
      t.integer :width
      t.string :url, null: false
      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
