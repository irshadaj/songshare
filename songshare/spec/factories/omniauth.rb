FactoryGirl.define do
  factory :auth, class: OmniAuth::AuthHash do
    skip_create

    transient do
      name { Faker::Name.name }
      sequence(:nickname) { |i| Faker::Internet.user_name(name) << i }
      email { Faker::Internet.email(name) }
      token 'xxxx'
      refresh_token 'xxxxx'
      expires_at nil
    end

    provider 'spotify'
    uid { nickname }

    info do
      {
        name: name,
        nickname: nickname,
        email: email,
        external_urls: {
          spotify: "https://open.spotify.com/user/#{uid}",
        },
      }
    end

    credentials do
      {
        token: token,
        refresh_token: refresh_token,
        expires: !!expires_at,
        expires_at: expires_at,
      }
    end

    extra do
      {
        raw_info: {
          country: 'US',
          display_name: nickname,
          email: email,
          external_urls: {
            spotify: "https://open.spotify.com/user/#{uid}",
          },
          href: "https://api.spotify.com/v1/users/#{uid}",
          id: uid,
          product: 'open',
          type: 'user',
          uri: "spotify:user:#{uid}",
        }
      }
    end
  end
end
