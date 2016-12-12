class CreateArtistsAlbums < ActiveRecord::Migration[5.0]
  def change
    create_join_table :albums, :artists

    add_foreign_key :albums_artists, :artists
    add_foreign_key :albums_artists, :albums
  end
end
