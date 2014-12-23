# encoding: utf-8
desc "Get youtube video information"
task :fetch_youtube_videos, [:fetch_number] => :environment do|t, args|
  require 'youtube_it'
  if args.fetch_number
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 4
  end

  client = YouTubeIt::Client.new(:dev_key => "AIzaSyBktwEa5lFm87ENBHmAGWJMCTChS282Whk")

  channels = RESOURCES_CONSTANT::YOUTUBE_MAGICIAN_CHANNELS + RESOURCES_CONSTANT::YOUTUBE_MAGIC_SHOP_CHANNELS
  channels.each do |channel|
    channel_id = channel[:url].split('channel/')[1]
    query = {
        author: channel_id,
        order_by: 'published',
        fields: {:published  => ((Date.today - fetch_number)..(Date.today))},
        page: 1,
    }
    videos = client.videos_by(query).videos
    videos.each do |video_info|
      url = video_info.player_url.gsub(/[?&]feature=youtube_gdata_player/, '')
      puts url
      video = Video.new(url: url)
      if video.save
        puts video.title + 'saved'
      end
    end
  end
end



