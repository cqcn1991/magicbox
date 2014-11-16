# encoding: UTF-8
class Video < ActiveRecord::Base
  validates :url, :title, :img_url,  presence: true
  validates :source_id, uniqueness: true
  before_validation :get_info, on: :create

  scope :by_category, ->(category) { where category: category }
  scope :order_by_date, -> { order('created_at DESC, source_id ASC')}
  scope :order_by_hits, -> { order('hits IS NULL, hits DESC') }
  scope :order_by_duration, -> { order('duration IS NULL, duration DESC') }
  scope :created_in_days, ->(number)  {where('created_at >= ?', Time.zone.now - number.days)}
  scope :selected, -> { where(selected: true) }
  require 'open-uri'

  def get_info
    smart_add_url_protocol
    if self.is_youku?
      get_youku_info
    elsif self.is_tudou?
      get_tudou_info
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

  def get_hits
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
    end
    self.hits = hits
    self.save
  end

  def get_youku_id
    response = HTTParty.get("http://v.youku.com/player/getPlayList/VideoIDS/#{self.source_id}")
    decode_response =  ActiveSupport::JSON.decode(response)
    decode_response['data'][0]['videoid']
  end
end


