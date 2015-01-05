# encoding: UTF-8
class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :url, uniqueness: true

  scope :by_forum, ->(forum) { where source: forum }
  scope :by_category, ->(category) { where category: category }
  scope :order_by_date, -> {order('created_at DESC')}
  scope :order_by_update, -> {order('updated_at DESC')}
  scope :order_by_likes, -> { order('likes IS NULL, likes DESC') }
  scope :order_by_reply_number, -> {order('reply_number IS NULL, reply_number DESC') }
  scope :created_in_days, ->(number)  do
    filtered = where('created_at >= ?', Time.zone.now - number.days)
    if filtered.length < 4
      order(:created_at => :desc).limit(4) # takes last 4 created
    else
      filtered
    end
  end

  require 'open-uri'

  before_validation :get_info, on: :create

  def get_info
    url = self.url
    doc = Nokogiri::HTML(open(url))
    if self.source.blank?
      get_source_and_title(doc, url)
      get_likes(doc)
    end
    if self.source == 'cafe'
      #get_cafe_author_info(doc)
      get_cafe_abstraction_and_time(doc)
      categorize_post
    elsif self.source == 'tieba'
      get_tieba_abstraction(doc)
    end
  end

  def get_source_and_title(doc, url)
    if url.include? 'themagiccafe'
      self.source = 'cafe'
      self.title=doc.css("title").text.split('The Magic Cafe Forums - ')[1]
    end
  end

  def get_cafe_author_info(doc)
    avatar = doc.at("table.normal img.nb[alt='View Profile']")['src']
    url = 'http://www.themagiccafe.com/forums/' + avatar
    author_name = doc.at("table.normal strong").text
    self.avatar = url
    self.author_name = author_name
    puts url, author_name
  end

  def categorize_post
    forum_id =  self.url.split('&forum=')[1]
    if forum_id ==  '15'
      self.category = 'mental'
    elsif forum_id ==  '2'
      self.category = 'card'
    elsif forum_id ==  '218'
      self.category = 'new'
    elsif forum_id ==  '303' || forum_id ==  '110'
      self.category = 'review'
    end
  end

  def get_cafe_abstraction_and_time(doc)
    text = doc.at("table.normal .vat.w90 .w100").text
    time = doc.at("table.normal .vat.w90 span.b").text.split('Posted: ')[1]
    text = text.split(" ").first(100).join(" ")
    self.created_at = time.to_time(:utc)
    self.abstraction = text
  end

  def get_tieba_abstraction(doc)
    text = doc.at('#j_p_postlist .d_post_content').text.split('            ')[1]
    if text
      self.abstraction = text[0..300]
    else
      puts 'no text'
    end
  end

  def get_likes_or_reply_number(doc = nil)
    if !doc
      url = self.url
      doc = Nokogiri::HTML(open(url))
    end
    if self.source == 'cafe'
      self.get_likes(doc)
    elsif self.source == 'tieba'
      self.get_reply_number(doc)
    end
  end

  def get_likes(doc)
    likes = doc.at("table.normal span.midtext")
    if likes
      self.likes = likes.text.tr("^0-9", '').to_i
      puts self.likes
    else
      puts 'links are deleted'
      self.destroy
    end
  end

  def get_reply_number(doc)
    reply_number = doc.at('li.l_reply_num span').text.to_i
    self.reply_number = reply_number
    puts self.reply_number
  end
end
