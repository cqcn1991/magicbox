# encoding: utf-8
desc "Get youtube video information"
task :fetch_youtube_videos, [:fetch_number] => :environment do|t, args|
  require 'youtube_it'
  if args.fetch_number
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 7
  end

  max_mode =true if fetch_number == 0
  def get_channels_avatar(channels)
    # tv_famous_magicians = RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:shops]
    channels.each do |channel|
      channel_id = channel[:url].split('channel/')[1]
      query = {
          author: channel_id,
          max_results: 3   ### used when getting initial videos
      }
      video = client.videos_by(query).videos.first
      author = video.author
      doc = Nokogiri::HTML(open(author.uri))
      img_url = doc.css('thumbnail')[0]['url']
      puts "{url:'#{channel[:url]}', name: '#{author.name}',"
      puts "favicon:'#{img_url}'},"
    end
  end

  def get_video_by_keyword
    keywords =['Le grand Cabaret magic', 'penn teller fool us',
               'Cyril Takayama',
               'criss angel', 'penn teller', 'david blain',
               'magic circle magician', 'dynamo magician', 'derren brown', 'david berglas',
               'Mat Franco',
               'Magic Castle magician', 'ellen show magician']

    keywords.each do |keyword|
      query = {
          query: keyword,
          order_by: 'viewCount',
          #author: channel_id,
          #order_by: 'published', #viewCount, #rating
          # fields: {:published  => ((Date.today - fetch_number)..(Date.today))},
          max_results: 50
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

  client = YouTubeIt::Client.new(:dev_key => "AIzaSyBktwEa5lFm87ENBHmAGWJMCTChS282Whk")

  channels = RESOURCES_CONSTANT::YOUTUBE_MAGICIAN_CHANNELS + RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:shops]
  channels.each do |channel|
    channel_id = channel[:url].split('channel/')[1]
    query = {
        author: channel_id,
        order_by: 'published',
        # fields: {:published  => ((Date.today - fetch_number)..(Date.today))},
        # max_results: 50   ### used when getting initial videos
    }
    if !max_mode
      query[:fields] = {:published  => ((Date.today - fetch_number)..(Date.today))}
    else
      query[:max_results] = 50
      puts 'max mode'
    end
    videos = client.videos_by(query).videos
    videos.each do |video_info|
      url = video_info.player_url.gsub(/[?&]feature=youtube_gdata_player/, '')
      puts url
      keywords = ['Coffee with Dan', 'Exposé', 'THE SHIFT', 'Free Tick Friday']
      if !keywords.any? {|str| video_info.title.include? str}
        video = Video.new(url: url)
        if video.save
          puts video.title + 'saved'
        end
      end
    end
  end

end



