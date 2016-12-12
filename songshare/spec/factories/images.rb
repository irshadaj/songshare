FactoryGirl.define do
  factory :image, aliases: [:artist_image] do
    url { Faker::Placeholdit.image('100x100') }
    width 100
    height 100
    imageable_type :artist_type
    association :imageable, factory: :artist

    factory :album_image do
      imageable_type :album_type
      association :imageable, factory: :album
    end
  end
end
