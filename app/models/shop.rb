class Shop < ActiveRecord::Base
  has_many :items
  validates :url, uniqueness: true
end
