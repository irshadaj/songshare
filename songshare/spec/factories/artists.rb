FactoryGirl.define do
  factory :artist do
    external_id { SpecHelperMethods.random_alphanumeric(10) }
    name { Faker::Superhero.name }
  end
end
