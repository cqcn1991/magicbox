# encoding: utf-8
desc "Fetch Sites"
task :test_tudou => :environment do
  require 'nokogiri'
  require 'open-uri'
  url = 'http://www.tudou.com/programs/view/z_yCG7zm3Jk'
  Video.create(url: url)
end

