require 'cucumber/rails'
require 'factory_girl'
require 'site_prism'
require 'webmock/cucumber'
require_relative '../pages/site'

def load_fixture(filename)
  path = Rails.root.join('features', 'support', 'fixtures', filename)
  File.open(path, 'r', &:read)
end

def mock_oauth_spotify_requests
  stub_request(:get, 'https://api.spotify.com/v1/me/top/tracks')
    .with(query: hash_including(time_range: 'long_term'))
    .to_return(body: load_fixture('top_tracks.json'))
end

World(FactoryGirl::Syntax::Methods)
World(Rails.application.routes.url_helpers)

ActionController::Base.allow_rescue = false

begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise 'Add database_cleaner to your Gemfile.'
end

OmniAuth.config.test_mode = true # forces OmniAuth to use the auth hash

Around do |_scenario, block|
  auth = OmniAuth::AuthHash.new(FactoryGirl.build(:auth))
  OmniAuth.config.mock_auth[:spotify] = auth
  mock_oauth_spotify_requests
  DatabaseCleaner.cleaning(&block)
end

Cucumber::Rails::Database.javascript_strategy = :truncation
