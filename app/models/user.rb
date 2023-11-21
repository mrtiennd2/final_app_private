class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  paginates_per 4

  mount_uploader :avatar, ImageUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :followers,  foreign_key: :user_id,     class_name: 'Follower', dependent: :destroy
  has_many :followings, foreign_key: :follower_id, class_name: 'Follower', dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name,  presence: true, length: { maximum: 25 }
  validates :email,      presence: true, length: { maximum: 255 }
  validates :password,   presence: true, length: { maximum: 64 }, on: :create
  # validates :current_password, presence: true, if: -> { password.present? }

  def full_name
    fst_char = first_name || ' '
    snd_char = last_name || ' '
    "#{fst_char} #{snd_char}"
  end
end
