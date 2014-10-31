desc "import selected videos"
task :import_csv => :environment do |t, args|
  require 'csv'
  file = File.join(Rails.root, 'lib', 'tasks', 'microposts.csv')
  CSV.foreach(file, headers: true) do |row|
    next if $. < 120
    url = row['video_url']
    video = Video.new(url: url, selected: true)
    puts url
    if video.save
      puts video.title + 'saved'
    else
      puts 'file exist'
    end
  end
end