Devise.setup do |config|
  # config.mailer_sender = 'learners@enova.com'
  require 'devise/orm/active_record'
  config.skip_session_storage = [:http_auth]
  config.omniauth :spotify,
                  ENV['SPOTIFY_CLIENT_ID'],
                  ENV['SPOTIFY_CLIENT_SECRET'],
                  scope: 'user-read-private user-library-read user-follow-read playlist-read-private user-top-read'
end
