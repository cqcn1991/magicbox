class StaticPagesController < ApplicationController
  def home
    @items = Item.first(4)
    @videos = Video.first(4)
    @posts = Post.first(4)
  end
end
