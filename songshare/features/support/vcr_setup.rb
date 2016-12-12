require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.ignore_localhost = true
  c.cassette_library_dir = 'features/support/fixtures/vcr'
end

VCR.cucumber_tags do |t|
  t.tag '@record_top_tracks', record: :new_episodes
  t.tag '@vcr', use_scenario_name: true, record: :new_episodes
end
