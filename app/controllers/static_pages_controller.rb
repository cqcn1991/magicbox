class StaticPagesController < ApplicationController
  def home
    @shops = Shop.order_by_update.first(4)
    @videos = Video.first(4)
    @posts = Post.first(4)
  end

  def discussion

  end

  def selected
    if params[:number]
      number = params[:number].to_i
    else
      number = 7
    end
      @videos = Video.created_in_days(number).order_by_hits.first(4)
  end
end
