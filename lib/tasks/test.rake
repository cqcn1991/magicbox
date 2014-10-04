# encoding: utf-8
desc "Fetch Sites"
task :test_hits => :environment do
  require 'nokogiri'
  require 'open-uri'
  Video.all.each do |video|
    video.get_hits
    puts video.title, video.hits
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

