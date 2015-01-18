# encoding: utf-8
desc "Fetch Sites"
task :fetch_cafe_post, [:fetch_number] => :environment do |t, args|
  require 'nokogiri'
  require 'open-uri'

  if args.fetch_number.to_i > 0
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 4
  end

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
    (0..60).step(30) do |n|
      url = url_base + "&start=#{n}"
      doc = Nokogiri::HTML(open(url) )
      # 分类已经系在Post方法中
      doc.css("form table.normal tr")[2..30].reverse_each do |item_info|
        title = item_info.at('td.bgc2 a.b').text
        href = 'http://www.themagiccafe.com/forums/'+ item_info.at('td.bgc2 a.b')['href']
        views = item_info.css('td.midtext')[0].text.to_i
        rely_number = item_info.css('td.midtext')[1].text.to_i
        likes = item_info.css('td.midtext')[2].text.to_i
        updated_time = item_info.at('td.bgc2.w17 span.midtext').text.to_time(:utc)
        source = 'cafe'
        if likes >= 15
          post = Post.find_by(url: href)
          if post
            post.updated_at = updated_time
            post.save
            puts "#{post.title} updated #{updated_time.strftime("%m/%d")}"
          else
            save_post(title, href, source, likes, views, rely_number)
          end
        end
      end
    end
  end

end