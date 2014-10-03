class Notice < ActiveRecord::Base
  validates :content, presence: true
  default_scope{order('pinned DESC, created_at DESC')}
  before_save :shorten_url

end
