class Album < ApplicationRecord
  belongs_to :user
  has_many :photos
  validates :title, presence: true
end
