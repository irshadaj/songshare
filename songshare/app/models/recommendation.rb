class Recommendation < ApplicationRecord
  belongs_to :song
  belongs_to :from_user, :foreign_key => 'from', :class_name => 'User'
  belongs_to :to_user, :foreign_key => 'to', :class_name => 'User'

  validates :from, uniqueness: { scope: [:to, :song] }
end
