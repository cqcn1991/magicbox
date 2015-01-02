# encoding: utf-8
desc "Get youtube video information"
task :test_post => :environment do
  require 'youtube_it'

  client = YouTubeIt::Client.new(:dev_key => "AIzaSyBktwEa5lFm87ENBHmAGWJMCTChS282Whk")

  channels =  [
  #{url: 'https://www.youtube.com/channel/UCrPUg54jUy1T_wII9jgdRbg', name: 'Chris Ramsay'},
  #{url: 'https://www.youtube.com/channel/UCy91oXvS8KYkyv7uxmxi8rQ', name: 'Aymeric Romet'},
  #{url: 'https://www.youtube.com/channel/UCVVYBEv1TuD850VAGBlk6og', name: 'calen morelli'},
  #{url: 'https://www.youtube.com/channel/UC7TTtOQKMXTWWMtWQMIgVSA', name: 'Collins Key'},
  #{url: 'https://www.youtube.com/channel/UCYSPs2prjzY4NUGeGrxTsCg', name: 'Juan Muchamagia'},
  #{url: 'https://www.youtube.com/channel/UCagoz5xdDQtz4HLtNOuMkUw', name: 'Justin William'},
  #{url: 'https://www.youtube.com/channel/UCA_9qCytURKYtWsnq-U_mTQ', name: 'Kostya Kimlat'},
  #{url: 'https://www.youtube.com/channel/UC7wBixlvRPRmfT7DNgVGGeA', name: 'Lee Asher'},
  #{url: 'https://www.youtube.com/channel/UCvzwg8ZePh0tDbQcJZTKQfw', name: 'Mac King'},
  #{url: 'https://www.youtube.com/channel/UCqr6tYc9Bollsoi2qRXsj7w', name: 'Mike Dynamo'},
  #{url: 'https://www.youtube.com/channel/UC1MO_rwTDJt1GpOH6ysYlnw', name: 'RandyMagician'},
  #{url: 'https://www.youtube.com/channel/UCRHFSYD-YngJVuNxq_D2sKQ', name: 'Rick Lax'},
  #{url: 'https://www.youtube.com/channel/UCP6ArLyC1pBb8fFuOGwZXHw', name: 'Rocco Magician'},
  #{url: 'https://www.youtube.com/channel/UCLESI66b8Efqw9EjFteMbbg', name: 'Spidey'},
  #{url: 'https://www.youtube.com/channel/UC96habYGr7PRl0iNd9qSEHg', name: 'Nontricks'},
  #{url: 'https://www.youtube.com/channel/UCbBlxMLe_5YCGnnJbNg9BDQ', name: 'SansMind'},
  #{url: 'https://www.youtube.com/channel/UCiBzwRBK8Q34pkRuZKNN1Lg', name: 'World Of Magic'},
  #{url: 'https://www.youtube.com/channel/UCp-UJCv7ACFtbpEEJx6E-Fw', name: 'worldmagicshop'},
  #{url: 'https://www.youtube.com/channel/UCxF9QEJstKhXkdk1FpUDMyQ', name: 'VanishingIC'},
  #{url: 'https://www.youtube.com/channel/UCbBlxMLe_5YCGnnJbNg9BDQ', name: 'SansMind'},
  # Fool Us Topic
  #{url: 'https://www.youtube.com/channel/UCyFWApPn_CYEIH9pF_sjvJw', name: 'Fool Us'},

  {url: 'https://www.youtube.com/channel/UCOn_hpazVfS7ZSX00eLZKdA', name: '770pratik'},
  {url: 'https://www.youtube.com/channel/UC4F9G58rQlCaJqGX6oeZhHg', name: ' cardinimagican'},

]

  #channels = RESOURCES_CONSTANT::YOUTUBE_MAGICIAN_CHANNELS + RESOURCES_CONSTANT::YOUTUBE_MAGIC_SHOP_CHANNELS
  channels.each do |channel|
    channel_id = channel[:url].split('channel/')[1]
    query = {
        author: channel_id,
        order_by: 'published',
        #fields: {:published  => ((Date.today - fetch_number)..(Date.today))},,
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






