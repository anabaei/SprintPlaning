class User < ApplicationRecord
  has_secure_password
  has_many :likes, dependent: :nullify
  has_many :liked_activity, through: :likes, source: :activity
end
