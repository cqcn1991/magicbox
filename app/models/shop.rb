class Shop < ActiveRecord::Base
  has_many :items, dependent: :destroy
  validates :url, uniqueness: true

  scope :order_by_update, -> {order('updated_at DESC')}

  def last_updated_at
    self.items.first.created_at
  end
end
