class FindTopTracks
  def self.find_all(spotify_user)
    spotify_results = spotify_user.top_tracks(time_range: 'long_term')
    spotify_results.map { |result| load_song(result) }
  end

  def self.load_song(spotify_track)
    song = Song.find_by_external_id(spotify_track.id)
    return song if song

    Song.create_from_spotify_track(spotify_track).tap do |song|
      load_artists(song, spotify_track.artists)
    end
  end

  private_class_method :load_song

  def self.load_artists(song, spotify_artists)
    artists = spotify_artists.map { |artist| Artist.from_spotify_artist(artist) }
    song.artists.concat(artists)
  end

  private_class_method :load_artists
end
