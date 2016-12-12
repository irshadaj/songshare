require_relative 'home_page'
require_relative 'songs/song_results_page'

module Site
  def self.home
    @home ||= HomePage.new
  end

  def self.song_results
    @song_results ||= SongResultsPage.new
  end
end
