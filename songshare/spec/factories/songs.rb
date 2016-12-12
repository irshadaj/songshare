FactoryGirl.define do
  factory :song do
    external_id { SpecHelperMethods.random_alphanumeric(10) }
    title { Faker::Book.title }
    disc_number 1
    sequence(:track_number)
    album
    artists { build_list(:artist, 1) }
  end
end
