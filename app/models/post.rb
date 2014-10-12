class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :url, uniqueness: true

  scope :by_forum, ->(forum) { where source: forum }
  default_scope{order('created_at DESC')}
  scope :order_by_likes, -> { reorder('likes DESC') }
  scope :created_in_days, ->(number)  {where('created_at >= ?', Time.zone.now - number.days)}

  require 'open-uri'

  after_create :get_info

  def get_info
    url = self.url
    doc = Nokogiri::HTML(open(url))
    if self.source == 'cafe'
      #get_cafe_author_info(doc)
      get_cafe_abstraction(doc)
    end
  end

  def get_cafe_author_info(doc)
    avatar = doc.at("table.normal img.nb[alt='View Profile']")['src']
    url = 'http://www.themagiccafe.com/forums/' + avatar
    author_name = doc.at("table.normal strong").text
    self.avatar = url
    self.author_name = author_name
    self.save
    puts url, author_name
  end

  def get_cafe_abstraction(doc)
    text = doc.at("table.normal .vat.w90 .w100").text
    text = text.split(" ").first(100).join(" ")
    self.abstraction = text
    self.save
  end

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
