# encoding: utf-8
desc "Fetch Sites"
task :fetch_post => :environment do
  require 'nokogiri'
  require 'open-uri'

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
  doc.css(".bm_c.cl a").first(4).each do |item_info|
    title = item_info.text
    href = 'http://www.collegemagic.cn/'+ item_info['href']
    source = '高魔'
    save_post(title, href, source)
  end

  url = 'http://tieba.baidu.com/f/good?kw=%C4%A7%CA%F5'
  doc = Nokogiri::HTML(open(url) )
  puts doc.css("title").text
  doc.css("ul#thread_list li.j_thread_list").first(4).each do |item_info|
    title = item_info.css('a.j_th_tit')[0]['title']
    href = 'http://tieba.baidu.com' + item_info.css('a.j_th_tit')[0]['href']
    source = '贴吧'
    save_post(title, href, source)
  end

  magic_cafe = ['15', '2', '218']
  magic_cafe.each do |forum|
    url = 'http://www.themagiccafe.com/forums/viewforum.php?forum=' + forum
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    doc.css("form table.normal tr")[2..30].each do |item_info|
      title = item_info.css('td.bgc2 a.b')[0].text
      href = 'http://www.themagiccafe.com/forums/'+ item_info.css('td.bgc2 a.b')[0]['href']
      likes = item_info.css('td.midtext')[2].text.to_f
      source = 'cafe'
      if likes >= 15
        save_post(title, href, source)
      end
    end
  end

end