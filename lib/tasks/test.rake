# encoding: utf-8
desc "Get youtube video information"
task :test_post => :environment do
  require 'youtube_it'
  require 'nokogiri'
  require 'open-uri'

  #method should be put first in a script
  def save_post(title, href, source, likes = nil, views = nil, reply_number = nil, category = nil)
    post = Post.new(title: title, url: href, source: source, likes: likes, views: views, reply_number: reply_number, category: category)
    if post.save
      puts "NEW: #{title} saved"
    end
  end

  magic_cafe = [{forum_id:  '15', forum_name: 'Penny for your thoughts'},
                {forum_id:  '2', forum_name: 'The workers'},
                {forum_id:  '218', forum_name: 'Latest and Greatest?'},
                {forum_id:  '110', forum_name: 'Books, Pamphlets & Lecture Notes'},
                {forum_id:  '303', forum_name: 'Mentally Speaking'},]
  #Penny, Workers, Latest and Greatest?
  magic_cafe.each do |forum|
    url_base = 'http://www.themagiccafe.com/forums/viewforum.php?forum=' + forum[:forum_id]
    puts "... #{forum[:forum_id]} #{forum[:forum_name]} starts"
    # 2070 for over the years
    (0..2070).step(30) do |n|
      url = url_base + "&start=#{n}"
      doc = Nokogiri::HTML(open(url) )
      # 分类已经系在Post方法中
      doc.css("form table.normal tr")[2..30].reverse_each do |item_info|
        title = item_info.at('td.bgc2 a.b').text
        href = 'http://www.themagiccafe.com/forums/'+ item_info.at('td.bgc2 a.b')['href']
        rely_number = item_info.css('td.midtext')[0].text.to_i
        views = item_info.css('td.w5.midtext')[1].text.delete(",").to_i
        likes = item_info.css('td.midtext')[2].text.to_i
        updated_time = item_info.at('td.bgc2.w17 span.midtext').text.to_time(:utc)
        source = 'cafe'
        if likes >= 15
          post = Post.find_by(url: href)
          if post
            post.updated_at = updated_time
            post.views = views
            post.reply_number = rely_number
            post.save
            puts "#{post.title} updated #{updated_time.strftime("%m/%d")} views: #{views}, replies: #{rely_number}"
          else
            save_post(title, href, source, likes, views, rely_number)
          end
        end
      end
    end
  end



  #client = YouTubeIt::Client.new(:dev_key => "AIzaSyBktwEa5lFm87ENBHmAGWJMCTChS282Whk")
  #
  #tv_famous_magicians = RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:award_winning_magician]
  #tv_famous_magicians.each do |channel|
  #  channel_id = channel[:url].split('channel/')[1]
  #  query = {
  #      author: channel_id,
  #      max_results: 3   ### used when getting initial videos
  #  }
  #  video = client.videos_by(query).videos.first
  #  author = video.author
  #  doc = Nokogiri::HTML(open(author.uri))
  #  img_url = doc.css('thumbnail')[0]['url']
  #  puts "{url:'#{channel[:url]}', name: '#{author.name}',"
  #  puts "favicon:'#{img_url}'},"
  #end


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






