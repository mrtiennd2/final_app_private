class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album, optional: true
  before_create :add_template_image_url

  scope :private_mode, -> { where(is_public: false) }
  scope :public_mode, -> { where(is_public: true) }

  # testing
  private
  def add_template_image_url
    self.image_url = "https://mdbcdn.b-cdn.net/img/new/standard/nature/184.webp"
  end
end
