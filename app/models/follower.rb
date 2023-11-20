class Follower < ApplicationRecord
  belongs_to :user
  belongs_to :following_user, foreign_key: :follower_id, class_name: 'User'
  validates_uniqueness_of :user_id, scope: :follower_id
end
