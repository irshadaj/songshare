require_relative '../../support/spec_helper_methods'

FactoryGirl.define do
  factory :spotify_track, class: RSpotify::Track do
    skip_create

    id { SpecHelperMethods.random_alphanumeric(20) }
    name { Faker::Book.title }
    disc_number 1
    sequence(:track_number)
    explicit false
    duration_ms { rand(30_000..1_320_000) }
    album { build(:spotify_album).as_json }

    trait :with_artists do
      transient do
        artist_count 1
      end

      artists { build_list(:spotify_artist, artist_count).map(&:as_json) }
    end

    initialize_with { new(attributes.stringify_keys) }
  end
end
