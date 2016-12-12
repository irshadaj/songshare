class Album < ApplicationRecord
  has_and_belongs_to_many :artists
  has_many :songs, inverse_of: :album

  has_many :images, as: :imageable, dependent: :destroy, autosave: true

  validates_presence_of :external_id, :name

  def self.from_spotify_album(spotify_album)
    album = find_by_external_id(spotify_album.id)
    return album if album

    album = create!(external_id: spotify_album.id) do |a|
      a.name = spotify_album.name
      a.genres = spotify_album.genres
      a.year = extract_year(spotify_album.release_date)
      a.album_type = spotify_album.album_type
    end

    album.images.create!(spotify_album.images)
    album
  end

  def self.extract_year(date)
    return nil unless date
    date.split('-').first.to_i
  end

  private_class_method :extract_year
end
