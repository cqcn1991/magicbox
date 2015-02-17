# encoding: utf-8
desc "Get youtube video information"
task :test_post => :environment do
  require 'youtube_it'
  require 'nokogiri'
  require 'open-uri'

  # input_file = 'lib/subtitle_en'
  # text = File.open(input_file, "r:UTF-8", &:read)

  text= '1
00:00:00000  -->00:00:00000
2
00:00:00730  -->00:00:04280
当Sam跟我发邮件讲要做这个课程
So when Sam originally sent me an email to do this course,
3
00:00:04280  -->00:00:08400
他说Ben你可以讲一个50分钟的管理方面课程
he said Ben can you teach a 50 minute course on management.
4
00:00:08400  -->00:00:09980
我立刻就想 我天
And I immediately thought to myself, wow,'

  puts text.gsub(/(\d{2})(\d{3})/, '\1,\2')
  # text = "00:00:04280  -->00:00:08400"
  # text = File.open(input_file, "r:UTF-8", &:read)
  # new_contents = text.gsub(/(\d{2})(\d{3})/, '\1,\2')
  # # # To write changes to the file, use:
  # File.open(output_file, "w:UTF-8") {|file| file.puts new_contents }

#中文名、作者、原文名&地址、译者、译文地址 这样来。
  # readings = []
  # url = 'http://startupclass.samaltman.com/lists/readings/'
  # doc = Nokogiri::HTML(open(url) )
  # puts doc.css("title").text
  # doc.css("li ul li").each do |reading_info|
  #   if reading_info.at('a')
  #     number = reading_info.text.split(':')[0]
  #     en_url = reading_info.at('a')['href']
  #     en_title = reading_info.at('a').text
  #     author = reading_info.text.split('by ')[1]
  #     puts "#{en_title} by #{author}"
  #     puts en_url
  #     reading = {
  #           number: number,
  #           cn_title:'',
  #           author:author,
  #           en_title:en_title,
  #           url:en_url,
  #           cn_url:'',
  #           cn_translator: ''}
  #     readings << reading
  #   end
  # end

  # file = 'lib/reading_cn.yml'
  # readings = YAML::load(File.read(file))
  # readings.each do |reading|
  #   puts "#{reading[:number]}"
  #   puts "[#{reading[:en_title]}](#{reading[:url]}) by #{reading[:author]}"
  #   if !reading[:cn_translator].blank?
  #     puts ' '
  #     puts "[#{reading[:cn_title]}](#{reading[:cn_url]}) by #{reading[:cn_translator]}"
  #   end
  # end

  # client = YouTubeIt::Client.new(:dev_key => "AIzaSyBktwEa5lFm87ENBHmAGWJMCTChS282Whk")
  #
  # tv_famous_magicians = RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:shops]
  # tv_famous_magicians.each do |channel|
  #   channel_id = channel[:url].split('channel/')[1]
  #   query = {
  #       author: channel_id,
  #       max_results: 3   ### used when getting initial videos
  #   }
  #   video = client.videos_by(query).videos.first
  #   author = video.author
  #   doc = Nokogiri::HTML(open(author.uri))
  #   img_url = doc.css('thumbnail')[0]['url']
  #   puts "{url:'#{channel[:url]}', name: '#{author.name}',"
  #   puts "favicon:'#{img_url}'},"
  # end


  #keywords =['Le grand Cabaret magic', 'penn teller fool us',
  #           'Cyril Takayama',
  #           'criss angel', 'penn teller', 'david blain',
  #           'magic circle magician', 'dynamo magician', 'derren brown', 'david berglas',
  #           'Mat Franco',
  #          'Magic Castle magician', 'ellen show magician']
  #
  #keywords.each do |keyword|
  #  query = {
  #      query: keyword,
  #      order_by: 'viewCount',
  #      #author: channel_id,
  #      #order_by: 'published', #viewCount, #rating
  #      ##fields: {:published  => ((Date.today - fetch_number)..(Date.today))},,
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

#
#  channels =  [
#  #{url: 'https://www.youtube.com/channel/UCrPUg54jUy1T_wII9jgdRbg', name: 'Chris Ramsay'},
#  #{url: 'https://www.youtube.com/channel/UCy91oXvS8KYkyv7uxmxi8rQ', name: 'Aymeric Romet'},
#  #{url: 'https://www.youtube.com/channel/UCVVYBEv1TuD850VAGBlk6og', name: 'calen morelli'},
#  #{url: 'https://www.youtube.com/channel/UC7TTtOQKMXTWWMtWQMIgVSA', name: 'Collins Key'},
#  #{url: 'https://www.youtube.com/channel/UCYSPs2prjzY4NUGeGrxTsCg', name: 'Juan Muchamagia'},
#  #{url: 'https://www.youtube.com/channel/UCagoz5xdDQtz4HLtNOuMkUw', name: 'Justin William'},
#  #{url: 'https://www.youtube.com/channel/UCA_9qCytURKYtWsnq-U_mTQ', name: 'Kostya Kimlat'},
#  #{url: 'https://www.youtube.com/channel/UC7wBixlvRPRmfT7DNgVGGeA', name: 'Lee Asher'},
#  #{url: 'https://www.youtube.com/channel/UCvzwg8ZePh0tDbQcJZTKQfw', name: 'Mac King'},
#  #{url: 'https://www.youtube.com/channel/UCqr6tYc9Bollsoi2qRXsj7w', name: 'Mike Dynamo'},
#  #{url: 'https://www.youtube.com/channel/UC1MO_rwTDJt1GpOH6ysYlnw', name: 'RandyMagician'},
#  #{url: 'https://www.youtube.com/channel/UCRHFSYD-YngJVuNxq_D2sKQ', name: 'Rick Lax'},
#  #{url: 'https://www.youtube.com/channel/UCP6ArLyC1pBb8fFuOGwZXHw', name: 'Rocco Magician'},
#  #{url: 'https://www.youtube.com/channel/UCLESI66b8Efqw9EjFteMbbg', name: 'Spidey'},
#  #{url: 'https://www.youtube.com/channel/UC96habYGr7PRl0iNd9qSEHg', name: 'Nontricks'},
#  #{url: 'https://www.youtube.com/channel/UCbBlxMLe_5YCGnnJbNg9BDQ', name: 'SansMind'},
#  #{url: 'https://www.youtube.com/channel/UCiBzwRBK8Q34pkRuZKNN1Lg', name: 'World Of Magic'},
#  #{url: 'https://www.youtube.com/channel/UCp-UJCv7ACFtbpEEJx6E-Fw', name: 'worldmagicshop'},
#  #{url: 'https://www.youtube.com/channel/UCxF9QEJstKhXkdk1FpUDMyQ', name: 'VanishingIC'},
#  #{url: 'https://www.youtube.com/channel/UCbBlxMLe_5YCGnnJbNg9BDQ', name: 'SansMind'},
#  # Fool Us Topic
#  #{url: 'https://www.youtube.com/channel/UCyFWApPn_CYEIH9pF_sjvJw', name: 'Fool Us'},
#]
#
#  channels = RESOURCES_CONSTANT::YOUTUBE_MAGICIAN_CHANNELS + RESOURCES_CONSTANT::YOUTUBE_MAGIC_SHOP_CHANNELS
#  channels.each do |channel|
#    channel_id = channel[:url].split('channel/')[1]
#    query = {
#        author: channel_id,
#        order_by: 'published',
#        #fields: {:published  => ((Date.today - fetch_number)..(Date.today))},,
#        max_results: 50
#    }
#    videos = client.videos_by(query).videos
#    videos.each do |video_info|
#      url = video_info.player_url.gsub(/[?&]feature=youtube_gdata_player/, '')
#      puts url
#      video = Video.new(url: url)
#      if video.save
#        puts video.title + 'saved'
#      end
#    end
#  end

end






