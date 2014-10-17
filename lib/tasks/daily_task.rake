# encoding: utf-8
desc "Daily Task"
task :fetch_all,  [:fetch_number] => :environment do |t, args|
  if args.fetch_number
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 4
  end

  Rake::Task["fetch_taobao"].invoke(fetch_number)
  Rake::Task["fetch_video"].invoke(fetch_number)
  Rake::Task["fetch_post"].invoke(fetch_number)
end

desc "Weekly Task"
task :fetch_popularity => :environment do
  require 'nokogiri'
  require 'open-uri'
  Video.all.each do |video|
    video.get_hits
    puts video.title, video.hits
  end

  Item.all.each do |item|
    item.get_sales_number
    puts item.title, item.sales_number
  end

  Post.all.each do |post|
    post.get_likes_or_reply_number
  end
end