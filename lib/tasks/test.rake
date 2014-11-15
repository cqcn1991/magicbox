# encoding: utf-8
desc "Fetch Sites"
task :test_post => :environment do
  require 'nokogiri'
  require 'open-uri'

  posts = Post.all
  posts.each do |post|
    if post.source == 'cafe'
      forum_id = post.url.split('forum=')[1]
      if  forum_id == '218'
        post.category = '新品'
      elsif forum_id == '2'
        post.category = '纸牌'
      elsif forum_id == '15'
        post.category = '心灵'
      end
      post.save
      puts post.title, post.category
    end
  end

end

