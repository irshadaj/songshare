FactoryGirl.define do
  factory :album do
    external_id { SpecHelperMethods.random_alphanumeric(10) }
    name { Faker::Book.title }
    album_type { %w(album single compilation).sample }
  end
end
