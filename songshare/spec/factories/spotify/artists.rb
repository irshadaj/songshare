require_relative '../../support/spec_helper_methods'

FactoryGirl.define do
  factory :spotify_artist, class: RSpotify::Artist do
    skip_create

    transient do
      albums { [] }
    end

    id { SpecHelperMethods.random_alphanumeric(20) }
    name { Faker::Superhero.name }
    type 'artist'
    uri { "spotify:artist:#{id}" }
    genres { [] }
    images { [] }

    trait :with_images do
      transient do
        image_count 2
      end

      images { build_list(:spotify_image, image_count) }
    end

    trait :with_tracks do
      transient do
        track_count 2
      end

      tracks { build_list(:spotify_song, track_count).map(&:as_json) }
    end

    initialize_with { new(attributes.stringify_keys) }
  end
end
