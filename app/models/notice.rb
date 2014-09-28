class Notice < ActiveRecord::Base
  validates :content, presence: true
end
