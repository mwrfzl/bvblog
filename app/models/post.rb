class Post < ApplicationRecord
  paginates_per 5
  has_many :comments
  belongs_to :authentication
end
