class Comment < ApplicationRecord
	belongs_to :post, optional: true
end
