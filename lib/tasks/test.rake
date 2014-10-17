# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  Post.by_forum('tieba').reverse_each do |post|
    puts post.title
  end
end

