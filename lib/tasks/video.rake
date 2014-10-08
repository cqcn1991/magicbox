# encoding: utf-8
desc "Fetch Sites"
task :fetch_video, [:fetch_number] => :environment do |t, args|
  require 'nokogiri'
  require 'open-uri'

  if args.fetch_number.to_i > 0
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 4
  end

  youku_sites = ['UMTAyMDY5MTE2','UMzU5NjcwNzk2', 'UMTQ0ODgzOTQ0', 'UMTg1MzM3MzMy', 'UNTc0MDYxNjcy',
                 'UMTQzNDg2NzU2', 'UMjUyNDczNTA4', 'UNDI2NjE2MzI=', 'UMTU1Nzg4MzA0', 'UMjQ4MjgyMjEy',
                 'UMTg1NTc5ODgw', 'UMzY0OTU2ODgw', 'UMTI5MzQyMTQw', 'UNTAwMjg4Njg=']
  #按顺序，derren brown， themagicway, 张笑我， E-Chong， SomethingMagic,
  # 现实一种, 竹音, cheunglei, 兰色死鱼, 禾小口
  # 酒精一百二十度, 酒精百分一百二, 哈利波特魔术，ArtherChan
  youku_sites.each do |site|
    url = 'http://i.youku.com/u/' + site
    doc = Nokogiri::HTML(open(url) )
    puts doc.css("title").text
    doc.css(".YK-video .v")[0..fetch_number].each do |item|
      #抓取Youku新视频
      title = item.at(".v-meta-title a")['title'] rescue nil
      href = item.at(".v-link a")['href']
      id = href.split("id_")[1].split(".html")[0]
      img_url = item.at(".v-thumb img")['src']
      source = 'youku'
      video = Video.new(title: title, url: href, source_id: id, img_url: img_url, source: source)
      if video.save
        puts title + 'saved'
      end
    end
  end

  #fetch tudou
  response = HTTParty.get("http://www.tudou.com/home/item/list.do?uid=110747724&page=1&pageSize=20&sort=1&keyword=")
  puts 'fetch tudou'
  decode_response =  ActiveSupport::JSON.decode(response)
  decode_response['data']['data'][0..fetch_number].each do  |item|
      title = item['title']
      href = 'http://www.tudou.com/programs/view/'+ item['code']
      img_url = item['picurl']
      id = item['code']
      source = 'tudou'
      video = Video.new(title: title, url: href, source_id: id, img_url: img_url, source: source)
      if video.save
        puts title + 'saved'
      end
  end
end

