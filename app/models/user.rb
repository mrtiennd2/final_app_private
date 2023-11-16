class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # attr_accessor :first_name, :last_name

  paginates_per 1

  mount_uploader :avatar, ImageUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 25 },  on: %i[create update]
  validates :last_name,  presence: true, length: { maximum: 25 },  on: %i[create update]
  validates :email,      presence: true, length: { maximum: 255 }, on: %i[create update]
  validates :password,   presence: true, length: { maximum: 64 },  on: :create

  # validates :current_password, presence: false
end
