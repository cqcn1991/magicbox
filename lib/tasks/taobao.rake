# encoding: utf-8
desc "Fetch Sites"
task :fetch_taobao, [:fetch_number] => :environment do |t, args|
  require 'nokogiri'
  require 'open-uri'

  if args.fetch_number.to_i > 0
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 4
  end

  taobao_sites = Shop.all
  taobao_sites.each do |site|
    url = 'http://'+ site.url + "/search.htm?&search=y&orderType=newOn_desc"
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    doc.css(".item").first(fetch_number).compact.each do |item_info|
      #抓取淘宝新品
      title = item_info.at(".detail a").text
      href = item_info.at(".detail a")['href']
      price = item_info.at(".detail .c-price").text
      taobao_id = href.split("id=")[1]
      img_url = item_info.at(".photo img")['src']
      item = Item.new(title: title, url: href, taobao_id: taobao_id, img_url: img_url, shop: site, price: price)
      if item.save
        puts title + 'saved'
      end
    end
  end

end