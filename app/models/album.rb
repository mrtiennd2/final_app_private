class Album < ApplicationRecord
  paginates_per 4

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
end
