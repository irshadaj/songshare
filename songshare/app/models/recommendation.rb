class Recommendation < ApplicationRecord
  validates_presence_of :from, :to, :song
end
