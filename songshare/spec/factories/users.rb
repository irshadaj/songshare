FactoryGirl.define do
  factory :user do
    provider 'spotify'
    full_name { Faker::Name.name }
    sequence(:uid) { |i| [Faker::Internet.user_name(full_name), i].join('_') }
    email { Faker::Internet.email(full_name) }
    display_name { uid }
  end
end
