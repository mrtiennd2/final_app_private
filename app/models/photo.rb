class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album, optional: true
  before_create :add_template_image_url

  default_scope { order(created_at: :desc) }
  scope :private_mode, -> { where(is_public: false) }
  scope :public_mode, -> { where(is_public: true) }

  validates :title, presence: true, unless: :belongs_to_album?

  def belongs_to_album?
    self.album_id != nil
  end

  # testing
  private
  def add_template_image_url
    self.image_url = "https://mdbcdn.b-cdn.net/img/new/standard/nature/184.webp"
  end
end
