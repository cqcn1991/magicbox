# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  videos = Video.all
  videos.each do |video|
    if video.is_youku?
      response = HTTParty.get("http://v.youku.com/player/getPlayList/VideoIDS/#{video.source_id}")
      decode_response =  ActiveSupport::JSON.decode(response)
      if decode_response['data'][0]['title'] && decode_response['data'][0]
        username = decode_response['data'][0]['username']
        if username == 'arthurchan76'
          video.category = '新品'
          video.save
        elsif video.selected
          video.category = '表演'
          puts video.title
          video.save
        end
      end
    end
  end
end

