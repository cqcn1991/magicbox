# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  def save_post(title, href, source, likes = nil, reply_number = nil)
    post = Post.new(title: title, url: href, source: source, likes: likes, reply_number: reply_number)
    if post.save
      puts title + 'saved'
    end
  end

  magic_cafe = ['15', '2', '218']
  #Penny, Workers, Latest and Greatest?
  magic_cafe.each do |forum|
    url = 'http://www.themagiccafe.com/forums/viewforum.php?forum=' + forum
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    doc.css("form table.normal tr")[2..30].reverse_each do |item_info|
      title = item_info.at('td.bgc2 a.b').text
      href = 'http://www.themagiccafe.com/forums/'+ item_info.at('td.bgc2 a.b')['href']
      likes = item_info.css('td.midtext')[2].text.to_i
      source = 'cafe'
      if likes >= 15
        save_post(title, href, source, likes)
      end
    end
  end

  Notice.create(content: 'notice 1')
  Notice.create(content: '10月11日，Howard Hamburg线上讲座,购票链接http://item.taobao.com/item.htm?spm=a1z10.1.w4004-1583697974.3.mMHGr7&id=41257580973')
  Notice.create(content: 'notice 2')
  Notice.create(content: 'notice 3')
end

