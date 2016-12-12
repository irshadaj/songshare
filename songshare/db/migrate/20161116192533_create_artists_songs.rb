class CreateArtistsSongs < ActiveRecord::Migration[5.0]
  def change
    create_join_table :artists, :songs

    add_foreign_key :artists_songs, :artists
    add_foreign_key :artists_songs, :songs
  end
end
