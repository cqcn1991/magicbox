# encoding: utf-8
desc "Daily Task"
task :daily_task => :environment do
  Rake::Task["fetch_taobao"].invoke
  Rake::Task["fetch_video"].invoke
  Rake::Task["fetch_post"].invoke
end