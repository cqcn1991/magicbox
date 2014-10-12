class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :url, uniqueness: true
  scope :by_forum, ->(forum) { where source: forum }
  default_scope{order('created_at DESC')}
  scope :order_by_likes, -> { reorder('likes DESC') }

  def get_likes
    if self.source == 'cafe'
      doc = Nokogiri::HTML(open(self.url) )
      puts self.title
      likes = doc.at("table.normal span.midtext")
      if likes
        self.likes = likes.text.tr("^0-9", '').to_i
        self.save
        puts self.likes
      else
        puts 'links are deleted'
        self.destroy
      end
    end
  end
end
