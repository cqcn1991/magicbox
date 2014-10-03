class Item < ActiveRecord::Base
  belongs_to :shop, dependent: :destroy
  validates :url, :title, :img_url, :price, presence: true
  validates :taobao_id, uniqueness: true
  after_save :update_shop

  default_scope{order('taobao_id DESC')}

  private

  def update_shop
    self.shop.touch
  end
end
