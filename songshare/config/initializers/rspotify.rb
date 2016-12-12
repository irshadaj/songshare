require 'colorize'

unless (['SPOTIFY_CLIENT_ID', 'SPOTIFY_CLIENT_SECRET'] - ENV.keys).empty?
  puts 'You must add the SPOTIFY_CLIENT_ID and SPOTIFY_CLIENT_SECRET environment variables to run Songshare.'.red
  raise 'Missing environment variables'
end

RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])
