class Activity < ApplicationRecord
 has_many :likes, dependent: :nullify
 has_many :liked_user, through: :likes, source: :user
end
