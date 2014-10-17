# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  Post.by_forum('tieba').each do |post|
    post.likes = nil
    post.get_likes_or_reply_number
  end
end

