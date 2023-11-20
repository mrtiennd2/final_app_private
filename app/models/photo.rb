class Photo < ApplicationRecord
  paginates_per 4

  mount_uploader :image_url, ImageUploader

  belongs_to :user
  belongs_to :album, optional: true
  has_many :likes, as: :likeable, dependent: :destroy

  default_scope { order(created_at: :desc) }
  scope :private_mode, -> { where(is_public: false) }
  scope :public_mode, -> { where(is_public: true) }

  # validates :title, presence: true, if: -> { album_id.nil? }
  # validates :description, presence: true, if: -> { album_id.nil? }
  validates :image_url, presence: true
end
