class Album < ApplicationRecord
  paginates_per 4

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :photos, presence: true

  default_scope { where(is_public: true).order(created_at: :desc) }

  validates_associated :photos
  accepts_nested_attributes_for :photos, allow_destroy: true
end
