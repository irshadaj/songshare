FactoryGirl.define do
  factory :spotify_image, class: Hash do
    skip_create

    height 300
    width 300
    url { Faker::Placeholdit.image([height, width].join('x')) }

    initialize_with { attributes.stringify_keys }
  end
end
