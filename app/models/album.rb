class Album < ApplicationRecord
  paginates_per 1

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, as: :likeable

  validates :title, presence: true
end
