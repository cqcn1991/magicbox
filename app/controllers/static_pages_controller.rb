class StaticPagesController < ApplicationController
  def home
    @shops = Shop.first(4)
    @videos = Video.order_by_time.first(4)
    @posts = Post.first(4)

    @notices = Notice.all
  end
end
