class Album < ApplicationRecord
  paginates_per 4

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :photos, presence: true

  default_scope { order(created_at: :desc) }
  scope :public_mode, -> { where(is_public: true) }

  validates_associated :photos
  accepts_nested_attributes_for :photos, allow_destroy: true
end
