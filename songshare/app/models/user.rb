class User < ApplicationRecord
  devise :omniauthable, :trackable, omniauth_providers: [:spotify]

  has_many :friendships, inverse_of: :user
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', inverse_of: :friend
  has_many :friends, through: :friendships
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates_presence_of :provider, :uid, :full_name, :display_name

  def to_s
    full_name
  end

  def self.from_omniauth(auth)
    User.find_or_create_by!(provider: auth[:provider], uid: auth[:uid]) do |u|
      u.full_name = auth.dig(:info, :name)
      u.display_name = auth.dig(:info, :nickname)
      u.email = auth.dig(:info, :email)
    end
  end
end
