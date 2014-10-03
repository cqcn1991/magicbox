class StaticPagesController < ApplicationController
  def home
    @shops = Shop.first(4)
    @videos = Video.first(4)
    @posts = Post.first(4)

    @notices = Notice.all
  end
end
