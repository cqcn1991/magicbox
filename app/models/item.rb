class Item < ActiveRecord::Base
  belongs_to :shop, dependent: :destroy
  validates :url, :title, :img_url, :price, presence: true
  validates :taobao_id, uniqueness: true
end
