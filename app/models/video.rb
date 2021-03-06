# encoding: UTF-8
class Video < ActiveRecord::Base
  validates :url, :title, :img_url,  presence: true
  validates :source_id, uniqueness: true
  
  before_validation :get_info, on: :create
  after_initialize :init

  scope :by_category, ->(category) { where category: category }
  scope :by_source, ->(source) { where source: source }
  scope :order_by_date, -> { order('created_at DESC, source_id ASC')}
  scope :order_by_update, -> { order('updated_at DESC, source_id ASC')}
  scope :order_by_hits, -> { order('hits IS NULL, hits DESC') }
  # scope :order_by_rating, -> { order('rating IS NULL, rating DESC, hits DESC') }
  scope :order_by_duration, -> { order('duration IS NULL, duration DESC') }
  scope :order_by_id, -> {order('id DESC')}

  scope :order_by_rating, -> do
    where("likes > ? ", 5).to_a.sort_by{|video| video.likes.to_f/video.hits}.reverse
  end

  scope :best_of_the_month, ->(year, month) do
    time = Time.new(year, month)
    start_time = time.beginning_of_month
    end_time = time.end_of_month
    # where("created_at > ? AND created_at < ?", start_time, end_time).where("likes > ?", 15).where("rating > ?", 4.85).order_by_rating.to_a.uniq(&:author)
    where("created_at > ? AND created_at < ?", start_time, end_time).where("likes > ?", 15).where("rating > ?", 4.8).to_a.sort_by{|video| video.likes.to_f/video.hits}.reverse.uniq(&:author)
  end

  scope :selected_of_the_month, ->(year, month) do
    time = Time.new(year, month)
    start_time = time.beginning_of_month
    end_time = time.end_of_month
    where("created_at > ? AND created_at < ?", start_time, end_time).where("selected = ?", true).by_source('youtube')
  end

  scope :random_best_before,->(year, month) do
    time = Time.new(year, month)
    before_time = time.beginning_of_month
    where("created_at < ?", before_time).where("likes > ?", 15).where("rating > ?", 4.85).order_by_rating.to_a.uniq(&:author).shuffle
  end

  scope :updated_in_days, ->(number)  {where('updated_at >= ?', Time.zone.now - number.days)}
  scope :created_in_days, ->(number)  {where('created_at >= ?', Time.zone.now - number.days)}
  scope :selected, -> { where(selected: true)}
  require 'open-uri'

  def self.best_by_month
    date = Date.new(2012,1,1)
    monthly_videos = []
    while true
      videos = (Video.selected_of_the_month(date.year, date.month) + Video.best_of_the_month(date.year, date.month)).uniq
      monthly_videos << videos
      date += 1.month
      break if date > Date.today.beginning_of_month
    end
    monthly_videos
  end

  def init
    self.selected = false if (self.has_attribute? :selected) && self.selected.nil?
  end

  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(:dev_key => YouTubeITConfig.dev_key)
  end

  def important_author
    important_authors = RESOURCES_CONSTANT::YOUTUBE_CHANNELS.values.flatten
    match_authors = important_authors.select {|author| author[:name] == self.author }
    match_authors.first if match_authors.any?
  end

  def get_info
    smart_add_url_protocol
    if self.is_youku?
      get_youku_info
    elsif self.is_tudou?
      get_tudou_info
    elsif self.is_youtube?
      get_youtube_info
    end
  end

  def smart_add_url_protocol
    unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end


  def is_youku?
    if self.url.include?("youku")  && self.url.include?("id_") && !self.url.include?("playlist")
      true
    else
      false
    end
  end

  def is_tudou?
    #http://www.tudou.com/programs/view/KedeEo3TLdI
    if self.url.include?("tudou")  && self.url.include?("view/")
      true
    else
      false
    end
  end

  def is_youtube?
    if self.url.include?("youtube")  && self.url.include?("watch?v=")
      true
    else
      false
    end
  end

  def get_youku_info
    video_id = self.url.split("id_")[1]
    ampersand_position = video_id.index(".html")
    self.source_id = video_id[0..ampersand_position-1]
    response = HTTParty.get("http://v.youku.com/player/getPlayList/VideoIDS/#{self.source_id}/timezone/+08/version/5/source/out?password=&ran=2513&n=3")
    decode_response =  ActiveSupport::JSON.decode(response)
    if decode_response['data'][0]['title'] && decode_response['data'][0]
      self.title = decode_response['data'][0]['title']
      self.img_url = decode_response['data'][0]['logo']
      self.duration = decode_response['data'][0]['seconds'].to_i
      username = decode_response['data'][0]['username']
      if username == 'arthurchan76'
        self.category = '新品'
      end
    end
    self.source = 'youku'
  end

  def get_tudou_info
    url = self.url
    doc = Nokogiri::HTML(open(url))
    video_params = doc.css('body script').text
    self.title = video_params.split('kw: ')[1].split("'")[1]
    self.source_id = video_params.split('icode: ')[1].split("'")[1]
    self.img_url = video_params.split('pic: ')[1].split("'")[1]
    time = video_params.split('time: ')[1].split("'")[1]
    self.duration = time.split(':')[0].to_i*60 + time.split(':')[1].to_i
    self.source = 'tudou'
  end

  def get_youtube_info
    youtube_id = parse_youtube(self.url)
    video = Video.yt_session.video_by(youtube_id)
    self.title = video.title
    self.duration = video.duration
    self.hits = video.view_count
    self.img_url = "http://img.youtube.com/vi/#{youtube_id}/mqdefault.jpg"
    self.created_at ||= video.published_at.to_s
    self.author = video.author.name
    if video.rating
      self.rating = video.rating.average
      self.likes = video.rating.likes.to_i
    end
    self.source = 'youtube'
    self.source_id = youtube_id
  end

  def parse_youtube url
    regex = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
    url.match(regex)[1]
  end

  def get_hits
    begin
      if self.source == 'youku'
        video_id = self.get_youku_id
        response = HTTParty.get("http://v.youku.com/QVideo/~ajax/getVideoPlayInfo?&id=#{video_id}&type=vv")
        decode_response =  ActiveSupport::JSON.decode(response)
        hits = decode_response['vv'].to_i
      elsif self.source == 'tudou'
        response = HTTParty.get("http://index.youku.com/dataapi/getData?jsoncallback=page_play_model_exponentModel__getNum&num=100011&icode=#{self.source_id}")
        json =  /(\{.*\})/.match(response).to_s
        decode_response =  ActiveSupport::JSON.decode(json)
        hits = decode_response['result']['totalVv'].to_i
      elsif self.source == 'youtube'
        video_info = Video.yt_session.video_by(self.source_id)
        hits = video_info.view_count
        if video_info.rating
          self.rating = video_info.rating.average
          self.likes = video_info.rating.likes.to_i
        end
      end
      self.hits = hits
      self.save
    rescue OpenURI::HTTPError
      # Delete the entry
      self.destroy
    end
  end

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    #find(:all, :conditions => ["title like ? ", "%#{query}%"])
    where("title like ?", "%#{query}%")
  end

  def get_youku_id
    response = HTTParty.get("http://v.youku.com/player/getPlayList/VideoIDS/#{self.source_id}")
    decode_response =  ActiveSupport::JSON.decode(response)
    decode_response['data'][0]['videoid']
  end

end


