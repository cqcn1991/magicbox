# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  Post.all.each do |post|
    category = post.category
    if category == '新品'
      post.category = 'new'
    elsif category == '心灵'
      post.category = 'mental'
    elsif category == '纸牌'
      post.category = 'card'
    end
    if post.save
      puts post.category
    end
  end
end

