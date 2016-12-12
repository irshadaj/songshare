require_relative 'page'
require_relative 'friends/friends_list_section'
require_relative 'songs/top_tracks_section'

module Site
  class HomePage < Page
    set_url root_path

    section :top_tracks, TopTracksSection, '.top-tracks'
    section :friends_list, FriendsListSection, '.friends'
    element :page_title, 'h1'
  end
end
