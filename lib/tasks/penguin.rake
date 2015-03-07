# encoding: utf-8
desc "Get youtube video information"
task :fetch_penguin, [:fetch_number] => :environment do|t, args|
  require 'nokogiri'
  require 'open-uri'

  penguin_lectures = []
  for page_number in 1..17 do
    url ="http://www.penguinmagic.com/browse.php?c=live&p=#{page_number}"
    puts url
    doc = Nokogiri::HTML(open(url))
    doc.css("td[width='100%'] .splash").each do |item_info|
      title = item_info.at('.splash_text a b').text.gsub( "(Instant Download)", "").split('LIVE')[0]
      lecture_url = 'http://www.penguinmagic.com'+ item_info.at('.splash_text a')['href']
      thumbnail = item_info.at('.product_main_thumbnail img')['src']
      if item_info.at('.splash_avgStars img')
        stars_url = item_info.at('.splash_avgStars img')['src']
        stars = File.basename(stars_url, File.extname(stars_url)).to_i
        review_number = item_info.at('.splash_avgStars a').text.to_i
        lecture = {title: title, url: lecture_url, thumnail_url: thumbnail, stars: stars, review_number: review_number}
        penguin_lectures << lecture
      end
    end
  end

  file = 'lib/penguin.yml'
  open(file, 'w') { |f| YAML::dump(penguin_lectures, f) }
  lecs = YAML::load(File.read(file))

end



