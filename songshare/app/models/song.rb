class Song < ApplicationRecord
  has_and_belongs_to_many :artists
  belongs_to :album, inverse_of: :songs

  validates_presence_of :external_id, :title, :disc_number, :track_number
  validates_uniqueness_of :external_id

  default_scope { includes(:artists, :album) }

  def uri
    "spotify:track:#{external_id}"
  end

  def self.create_from_spotify_track(spotify_song, album: nil)
    create(attributes_from_spotify_track(spotify_song, album))
  end

  def self.create_from_spotify_track!(spotify_song, album: nil)
    create!(attributes_from_spotify_track(spotify_song, album))
  end

  def self.attributes_from_spotify_track(spotify_song, album)
    { external_id: spotify_song.id,
      title: spotify_song.name,
      disc_number: spotify_song.disc_number,
      track_number: spotify_song.track_number,
      explicit: spotify_song.explicit,
      duration: spotify_song.duration_ms,
      album: album || Album.from_spotify_album(spotify_song.album) }
  end

  private_class_method(:attributes_from_spotify_track)
end
