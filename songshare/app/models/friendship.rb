class Friendship < ApplicationRecord
  MUTUAL_SQL = <<-SQL
    EXISTS(
      SELECT 1 FROM friendships inverse_friendships
      WHERE friendships.user_id = inverse_friendships.friend_id AND friendships.friend_id = inverse_friendships.user_id
    )
  SQL

  belongs_to :user, inverse_of: :friendships
  belongs_to :friend, class_name: 'User', inverse_of: :inverse_friendships

  validates_presence_of :user, :friend
  validates_uniqueness_of :friend, scope: :user, message: "Friend '%{value}' already added"
  validate :validate_users

  scope :mutual, -> { where(MUTUAL_SQL) }
  scope :non_mutual, -> { where.not(MUTUAL_SQL) }

  def inverse
    self.class.find_by(user: friend, friend: user)
  end

  def confirmed?
    Friendship.exists?(user: friend, friend: user)
  end

  private

  def validate_users
    errors[:user] << 'cannot friend themselves' if user_id == friend_id
  end
end
