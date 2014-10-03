# encoding: utf-8
desc "Fetch Sites"
task :fetch_post, [:fetch_number] => :environment do |t, args|
  require 'nokogiri'
  require 'open-uri'

  if args.fetch_number.to_i > 0
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 4
  end

  #method should be put first in a script
  def save_post(title, href, source)
    post = Post.new(title: title, url: href, source: source)
    if post.save
      puts title + 'saved'
    end
  end

  url = 'http://www.collegemagic.cn/forum.php'
  doc = Nokogiri::HTML(open(url) )
  puts doc.css("title").text
  doc.css(".bm_c.cl a").first(fetch_number).compact.each do |item_info|
    title = item_info.text
    href = 'http://www.collegemagic.cn/'+ item_info['href']
    source = '高魔'
    save_post(title, href, source)
  end

  url = 'http://tieba.baidu.com/f/good?kw=%C4%A7%CA%F5'
  doc = Nokogiri::HTML(open(url) )
  puts doc.css("title").text
  doc.css("ul#thread_list li.j_thread_list").first(fetch_number).compact.each do |item_info|
    title = item_info.at('a.j_th_tit')['title']
    href = 'http://tieba.baidu.com' + item_info.at('a.j_th_tit')['href']
    source = '贴吧'
    save_post(title, href, source)
  end

  magic_cafe = ['15', '2', '218']
  #Penny, Workers, Latest and Greatest?
  magic_cafe.each do |forum|
    url = 'http://www.themagiccafe.com/forums/viewforum.php?forum=' + forum
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    doc.css("form table.normal tr")[2..30].each do |item_info|
      title = item_info.at('td.bgc2 a.b').text
      href = 'http://www.themagiccafe.com/forums/'+ item_info.at('td.bgc2 a.b')['href']
      likes = item_info.css('td.midtext')[2].text.to_f
      source = 'cafe'
      if likes >= 15
        save_post(title, href, source)
      end
    end
  end

end