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
  def save_post(title, href, source, likes = nil, reply_number = nil, category = nil)
    post = Post.new(title: title, url: href, source: source, likes: likes, reply_number: reply_number, category: category)
    if post.save
      puts title + 'saved'
    end
  end

  url = 'http://www.collegemagic.cn/forum.php'
  doc = Nokogiri::HTML(open(url) )
  puts doc.css("title").text
  doc.css(".bm_c.cl a")[0..fetch_number].reverse_each do |item_info|
    title = item_info.text
    href = 'http://www.collegemagic.cn/'+ item_info['href']
    source = 'gaomo'
    likes = 0
    save_post(title, href, source)
  end

  tiebas = ['%C4%A7%CA%F5','%D0%C4%C1%E9%C4%A7%CA%F5', '%BB%A8%C7%D0']
  tiebas.each do |tieba|
    url = 'http://tieba.baidu.com/f/good?kw=' + tieba
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    if tieba == '%D0%C4%C1%E9%C4%A7%CA%F5'
      category = '心灵'
    elsif tieba ==  '%BB%A8%C7%D0'
      category = '花式'
    end
    doc.css("ul#thread_list li.j_thread_list")[0..fetch_number].reverse_each do |item_info|
      title = item_info.at('a.j_th_tit')['title']
      reply_number = item_info.at('.threadlist_rep_num').text
      href = 'http://tieba.baidu.com' + item_info.at('a.j_th_tit')['href']
      source = 'tieba'
      save_post(title, href, source, nil, reply_number, category)
    end
  end


  magic_cafe = ['15', '2', '218', '110', '303']
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
      if likes >= 15
        save_post(title, href, source, likes)
      end
    end
  end

end