class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :title, presence: true
  validates :photos, presence: { message: 'Album needs to have photo' }
end
