# encoding: utf-8
desc "Get youtube video information"
task :subtitle => :environment do
  require 'youtube_it'
  require 'nokogiri'
  require 'open-uri'

  # input_file = 'lib/subtitle_en'
  # text = File.open(input_file, "r:UTF-8", &:read)

  text= '1
00:00:00000  -->00:00:00000
2
00:00:00730  -->00:00:04280
当Sam跟我发邮件讲要做这个课程
So when Sam originally sent me an email to do this course,
3
00:00:04280  -->00:00:08400
他说Ben你可以讲一个50分钟的管理方面课程
he said Ben can you teach a 50 minute course on management.
4
00:00:08400  -->00:00:09980
我立刻就想 我天
And I immediately thought to myself, wow,'

  puts text.gsub(/(\d{2})(\d{3})/, '\1,\2')
# text = "00:00:04280  -->00:00:08400"
# text = File.open(input_file, "r:UTF-8", &:read)
# new_contents = text.gsub(/(\d{2})(\d{3})/, '\1,\2')
# # # To write changes to the file, use:
# File.open(output_file, "w:UTF-8") {|file| file.puts new_contents }

#中文名、作者、原文名&地址、译者、译文地址 这样来。
# readings = []
# url = 'http://startupclass.samaltman.com/lists/readings/'
# doc = Nokogiri::HTML(open(url) )
# puts doc.css("title").text
# doc.css("li ul li").each do |reading_info|
#   if reading_info.at('a')
#     number = reading_info.text.split(':')[0]
#     en_url = reading_info.at('a')['href']
#     en_title = reading_info.at('a').text
#     author = reading_info.text.split('by ')[1]
#     puts "#{en_title} by #{author}"
#     puts en_url
#     reading = {
#           number: number,
#           cn_title:'',
#           author:author,
#           en_title:en_title,
#           url:en_url,
#           cn_url:'',
#           cn_translator: ''}
#     readings << reading
#   end
# end

# file = 'lib/reading_cn.yml'
# readings = YAML::load(File.read(file))
# readings.each do |reading|
#   puts "#{reading[:number]}"
#   puts "[#{reading[:en_title]}](#{reading[:url]}) by #{reading[:author]}"
#   if !reading[:cn_translator].blank?
#     puts ' '
#     puts "[#{reading[:cn_title]}](#{reading[:cn_url]}) by #{reading[:cn_translator]}"
#   end
# end
end