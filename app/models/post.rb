class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :url, uniqueness: true
end
