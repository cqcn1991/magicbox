# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  Post.by_forum('cafe').each do |post|
    if !post.abstraction
      post.get_info
      puts post.abstraction
    else
      'skip'
    end
  end
end

