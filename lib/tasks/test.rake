# encoding: utf-8
desc "Get youtube video information"
task :test_post => :environment do
  require 'youtube_it'

    client = YouTubeIt::Client.new(:dev_key => "AIzaSyBktwEa5lFm87ENBHmAGWJMCTChS282Whk")
    channels = [{url: 'https://www.youtube.com/channel/UCfrhuhTDSpVhK7omh_ZIKaw', name: "Murphy's Magic"},
                   {url: 'https://www.youtube.com/channel/UCEybzfsG2WI4Hnx5hpd2uRA', name: 'TheBlueCrownMagic'},
                   {url: 'https://www.youtube.com/channel/UCwlXbq5KtkdGC87oABDsfTQ', name: 'Dan & Dave'},
                   {url: 'https://www.youtube.com/channel/UCl1WwbVpKUdQerivZpUxZLA', name: 'Theory 11'},]

    channels.each do |channel|
      channel_id = channel[:url].split('channel/')[1]
      query = {
          author: channel_id,
          order_by: 'published',
      }
      videos = client.videos_by(query).videos
      videos.each do |video_info|
        url = video_info.player_url.gsub(/[?&]feature=youtube_gdata_player/, '')
        keywords = ['Coffee with Dan', 'Exposé', 'THE SHIFT', 'Free Tick Friday']
        if !keywords.any? {|str| video_info.title.include? str}
          puts "#{url} #{video_info.title}"
        end
        #video = Video.new(url: url)
      end
    end

    ##method should be put first in a script
    #def save_post(title, href, source, likes = nil, reply_number = nil, category = nil)
    #  post = Post.new(title: title, url: href, source: source, likes: likes, reply_number: reply_number, category: category)
    #  if post.save
    #    puts title + 'saved'
    #  end
    #end
    #
    #magic_cafe = ['15', '2','218', '110', '303']
    #magic_cafe.each do |forum|
    #  url = 'http://www.themagiccafe.com/forums/viewforum.php?forum=' + forum
    #  (30..2070).step(30) do |n|
    #    url = url + "&start=#{n}"
    #    doc = Nokogiri::HTML(open(url) )
    #    doc.css("form table.normal tr")[2..30].reverse_each do |item_info|
    #      title = item_info.at('td.bgc2 a.b').text
    #      href = 'http://www.themagiccafe.com/forums/'+ item_info.at('td.bgc2 a.b')['href']
    #      likes = item_info.css('td.midtext')[2].text.to_i
    #      source = 'cafe'
    #      if likes >= 15
    #        save_post(title, href, source, likes)
    #      end
    #    end
    #  end
    #end
    #



  #require 'youtube_it'
  #
  #client = YouTubeIt::Client.new(:dev_key => "AIzaSyBktwEa5lFm87ENBHmAGWJMCTChS282Whk")

  #channels =  [
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
  #
  ## Fool Us Topic
  #{url: 'https://www.youtube.com/channel/UCyFWApPn_CYEIH9pF_sjvJw', name: 'Fool Us'},]
  #
  #
  ##channels = RESOURCES_CONSTANT::YOUTUBE_MAGICIAN_CHANNELS + RESOURCES_CONSTANT::YOUTUBE_MAGIC_SHOP_CHANNELS
  #channels.each do |channel|
  #  channel_id = channel[:url].split('channel/')[1]
  #  query = {
  #      author: channel_id,
  #      order_by: 'published',
  #      #fields: {:published  => ((Date.today - fetch_number)..(Date.today))},,
  #      max_results: 50
  #  }
  #  videos = client.videos_by(query).videos
  #  videos.each do |video_info|
  #    url = video_info.player_url.gsub(/[?&]feature=youtube_gdata_player/, '')
  #    puts url
  #    video = Video.new(url: url)
  #    if video.save
  #      puts video.title + 'saved'
  #    end
  #  end
  #end
end






