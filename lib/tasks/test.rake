# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  videos = Video.all
  videos.each do |video|
    puts video.title, video.url
    if video.is_youku?
       video_id = video.url.split("id_")[1]
      ampersand_position = video_id.index(".html")
      video.source_id = video_id[0..ampersand_position-1]
      response = HTTParty.get("http://v.youku.com/player/getPlayList/VideoIDS/#{video.source_id}")
      decode_response =  ActiveSupport::JSON.decode(response)
      if decode_response['data'][0]['title'] && decode_response['data'][0]
        time = decode_response['data'][0]['seconds']
        video.duration = time.to_i
      end
    elsif video.is_tudou?
      url = video.url
      doc = Nokogiri::HTML(open(url))
      video_params = doc.css('body script').text
      video.title = video_params.split('kw: ')[1].split("'")[1]
      video.source_id = video_params.split('icode: ')[1].split("'")[1]
      video.img_url = video_params.split('pic: ')[1].split("'")[1]
      time = video_params.split('time: ')[1].split("'")[1]
      video.duration = time.split(':')[0].to_i*60 + time.split(':')[1].to_i
    end
    if video.save
      puts video.duration
    end
  end
end

