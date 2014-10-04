# encoding: utf-8
desc "Fetch Sites"
task :test_taobao => :environment do
  require 'nokogiri'
  require 'open-uri'

  Item.all.each do |item|
    item.get_sales_number
    puts item.title, item.sales_number
  end

=begin
  url = 'http://themagicway.taobao.com/search.htm?&search=y&orderType=newOn_desc'
  doc = Nokogiri::HTML(open(url) )
  puts doc.css(".main-wrap .item").count
  doc.css(".main-wrap .item").limit(30).each do |item_info|
    if item_info
      href = item_info.at(".detail a")['href']
      puts href
    else
      puts 'this is empty'
    end
  end
=end
end

