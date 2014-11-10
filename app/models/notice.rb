class Notice < ActiveRecord::Base
  validates :content, presence: true
  default_scope{order('pinned IS NULL, pinned DESC, created_at DESC')}
end
