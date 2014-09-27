class Item < ActiveRecord::Base
  belongs_to :shop
  validates :url, presence: true
  validates :taobao_id, uniqueness: true
end
