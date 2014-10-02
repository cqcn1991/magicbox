# encoding: UTF-8
class Video < ActiveRecord::Base
  validates :url, :title, :img_url,  presence: true
  validates :source_id, uniqueness: true
  before_validation :get_info, on: :create

  default_scope{order('created_at DESC, source_id ASC')}

  require 'open-uri'

  def get_info
    if self.source.empty?
      smart_add_url_protocol
      if self.is_youku?
        get_youku_info
      elsif self.is_tudou?
        get_tudou_info
      end
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
    self.title = decode_response['data'][0]['title']
    self.img_url = decode_response['data'][0]['logo']
    self.source = 'youku'
  end

  def get_tudou_info
    url = self.url
    doc = Nokogiri::HTML(open(url))
    video_params = doc.css('body script').text
    self.title = video_params.split('kw: ')[1].split("'")[1]
    self.source_id = video_params.split('icode: ')[1].split("'")[1]
    self.img_url = video_params.split('pic: ')[1].split("'")[1]
    self.source = 'tudou'
  end
end


