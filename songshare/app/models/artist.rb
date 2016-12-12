class Artist < ApplicationRecord
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :songs
  has_many :images, as: :imageable, dependent: :destroy, autosave: true

  validates_presence_of :external_id, :name

  def self.from_spotify_artist(spotify_artist)
    artist = find_by(external_id: spotify_artist.id)
    return artist if artist

    create_artist_from_spotify(spotify_artist)
  end

  def self.create_artist_from_spotify(spotify_artist)
    create!(external_id: spotify_artist.id,
            name: spotify_artist.name,
            genres: spotify_artist.genres)
  end

  private_class_method :create_artist_from_spotify
end
