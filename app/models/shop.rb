class Shop < ActiveRecord::Base
  has_many :items
  validates :url, uniqueness: true

  def last_updated_at
    self.items.first.created_at
  end
end
