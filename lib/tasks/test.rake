# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  def save_post(title, href, source, likes = nil, reply_number = nil, category = nil)
    post = Post.new(title: title, url: href, source: source, likes: likes, reply_number: reply_number, category: category)
    if post.save
      puts title + 'saved'
    end
  end

  magic_cafe = ['110', '303']
  #Penny, Workers, Latest and Greatest?
  magic_cafe.each do |forum|
    url = 'http://www.themagiccafe.com/forums/viewforum.php?forum=' + forum
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    # 分类已经系在Post方法中
    doc.css("form table.normal tr")[2..30].reverse_each do |item_info|
      title = item_info.at('td.bgc2 a.b').text
      href = 'http://www.themagiccafe.com/forums/'+ item_info.at('td.bgc2 a.b')['href']
      likes = item_info.css('td.midtext')[2].text.to_i
      source = 'cafe'
      if likes >= 10
        save_post(title, href, source, likes)
      end
    end
    end
end

