require_relative '../page'
require_relative '../pagination_section'
require_relative 'song_row_section'

module Site
  class SongResultsPage < Page
    set_url search_songs_path

    sections :paginations, PaginationSection, '.pagination'
    sections :songs, SongRowSection, '.song-list .song'
  end
end
