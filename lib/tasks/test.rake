# encoding: utf-8
desc "Get youtube video information"
task :test_youtube => :environment do
  Video.all.each do |video|
    if video.selected.nil?
      video.selected = false
      if video.save
        puts video.title
      end
    end
  end
end



