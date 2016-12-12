module SearchSongs
  def self.search(name, page: nil)
    spotify_results = RSpotify::Track.search(name, search_params(page || 1))
    songs = Song.transaction { spotify_results.map { |result| load_song(result) }}
    SearchResults.new(songs, limit: AppConfig.spotify.tracks.limit, page: page, total: spotify_results.total)
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

  def self.search_params(page)
    { market: AppConfig.spotify.market,
      offset: (page - 1) * AppConfig.spotify.tracks.limit,
      limit: AppConfig.spotify.tracks.limit }
  end

  private_class_method :search_params
end
