module Site
  class SongRowSection < SitePrism::Section
    element :title, '.song-title a'
    element :artists, '.song-artists'
    element :album, '.song-album'
    element :explicit_label, '.label-explicit'
    element :duration, '.song-duration'
    element :player, '.song-player'
  end
end
