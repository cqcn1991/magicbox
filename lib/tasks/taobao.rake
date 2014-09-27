# encoding: utf-8
desc "Fetch Sites"
task :fetch_taobao => :environment do
  require 'nokogiri'
  require 'open-uri'

  taobao_sites = Shop.all
  taobao_sites.each do |site|
    url = 'http://'+ site.url + "/search.htm?&search=y&orderType=newOn_desc"
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    doc.css(".item").first(4).each do |item_info|
      #抓取淘宝新品
      title = item_info.css(".detail a").text
      href = item_info.css(".detail a")[0]['href']
      price = item_info.css(".detail .c-price").text
      taobao_id = href.split("id=")[1]
      img_url = item_info.at(".photo img")['src']
      item = Item.new(title: title, url: href, taobao_id: taobao_id, img_url: img_url, shop: site, price: price)
      if item.save
        puts title + 'saved'
      else
        puts title + 'not saved'
      end
    end
  end

end