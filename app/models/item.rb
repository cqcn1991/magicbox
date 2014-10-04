class Item < ActiveRecord::Base
  belongs_to :shop, dependent: :destroy
  validates :url, :title, :img_url, :price, presence: true
  validates :taobao_id, uniqueness: true
  after_create :update_shop

  #scope :order_by_time, -> {order('taobao_id DESC')}
  default_scope  {order('taobao_id DESC')}
  scope :order_by_sales, -> {reorder('sales_number DESC') }

  def get_sales_number
    response = HTTParty.get("http://hws.m.taobao.com/cache/wdetail/5.0/?id=#{self.taobao_id}")
    decode_response =  ActiveSupport::JSON.decode(response)
    decode_response = decode_response['data']['apiStack'][0]['value']
    decode_response =  ActiveSupport::JSON.decode(decode_response)
    self.sales_number = decode_response['data']['itemInfoModel']['soldQuantityText'].tr("^0-9", '').to_i
    self.save
  end

  private

  def update_shop
    self.shop.touch
  end
end
