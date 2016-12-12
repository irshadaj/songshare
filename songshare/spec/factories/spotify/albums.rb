require_relative '../../support/spec_helper_methods'

FactoryGirl.define do
  factory :spotify_album, class: RSpotify::Album do
    skip_create

    id { SpecHelperMethods.random_alphanumeric(20) }
    name { Faker::Book.title }
    artists { [] }
    images { [] }
    genres { [] }
    release_date '2016'
    release_date_precision 'year'
    album_type { %w(album compilation single).sample }
    available_markets %w(CA US)
    type 'album'
    uri { "spotify:album:#{id}" }

    trait :with_artists do
      transient do
        artist_count 1
      end

      artists { build_list(:spotify_artist, artist_count).map(&:as_json) }
    end

    trait :with_images do
      transient do
        image_count 2
      end

      images { build_list(:spotify_image, image_count) }
    end

    initialize_with { new(attributes.stringify_keys) }
  end
end
