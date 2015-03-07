class ReportsController < ApplicationController
  def index

  end

  def penguin
    all_lectures = YAML::load(File.read('lib/penguin.yml'))
    @newest_lec = all_lectures.first
    @count = all_lectures.count
    lectures = all_lectures.sort_by { |hsh| [hsh[:stars],hsh[:review_number]] }.reverse
    params[:rating] = '5' if !params[:rating]
    case params[:rating]
      when 'all'
        lectures = lectures
      when '5'
        lectures = lectures.select {|l| l[:stars] >= 5}
      when '4'
        lectures = lectures.select {|l| l[:stars] == 4}
      when '3'
        lectures = lectures.select {|l| l[:stars] == 3}
    end
    @penguin_lectures = lectures
  end

  def best_in_cafe_2014
    start_time = Date.new(2014,1,1)
    end_time = Date.new(2015,1,1)
    posts = Post.where("created_at >= ? AND created_at < ?", start_time, end_time)
    if params[:sort] == 'like'
      posts = posts.order_by_likes
    elsif params[:sort] == 'create'
      posts = posts.order_by_date
    elsif params[:sort] == 'views'
      posts = posts.order_by_views
    else
      posts = posts.order_by_reply_number
    end
    @posts = posts.first(50)
  end
end
