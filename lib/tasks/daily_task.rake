# encoding: utf-8
desc "Daily Task"
task :fetch_all,  [:fetch_number] => :environment do |t, args|
  if args.fetch_number
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 4
  end

  Rake::Task["fetch_youtube_videos"].invoke(fetch_number)
  Rake::Task["fetch_cafe_post"].invoke(fetch_number)
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

task :fetch_recent_popularity, [:fetch_number] => :environment do |t, args|
  require 'nokogiri'
  require 'open-uri'
  if args.fetch_number.to_i > 0
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 14
  end
  Video.by_source('youtube').created_in_days(fetch_number).each do |video|
    video.get_hits
    puts video.title, video.hits
  end

  Rake::Task["fetch_post_popularity"].invoke(fetch_number)
end

task :fetch_post_popularity, [:fetch_number] => :environment do |t, args|
  require 'nokogiri'
  require 'open-uri'

  if args.fetch_number.to_i > 0
    fetch_number = args.fetch_number.to_i
  else
    fetch_number = 30
  end

  Post.by_forum('cafe').created_in_days(fetch_number).each do |post|
    puts post.title
    post.get_likes_or_reply_number
  end
end