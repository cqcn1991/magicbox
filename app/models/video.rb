class Video < ActiveRecord::Base
  validates :url, :title, :img_url,  presence: true
  validates :source_id, uniqueness: true
end
