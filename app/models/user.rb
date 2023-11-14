class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # attr_accessible :first_name, :last_name

  mount_uploader :avatar, ImageUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy

  # validates :first_name, presence: true, length: { maximum: 25 }
  # validates :last_name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, presence: true, length: { maximum: 64 }
end
