class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :url, uniqueness: true
  scope :by_forum, ->(forum) { where source: forum }
  default_scope{order('created_at DESC')}
end
