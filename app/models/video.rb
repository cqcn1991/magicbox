class Video < ActiveRecord::Base
  validates :url, :title, :img_url,  presence: true
  validates :source_id, uniqueness: true

  default_scope{order('source_id ASC')}
end
