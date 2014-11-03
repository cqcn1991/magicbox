class StaticPagesController < ApplicationController
  def home
    #@shops = Shop.order_by_update.first(4)
    @items = Item.order_by_date.to_a.uniq {|p| p.shop_id}[0..3]
    @videos = Video.order_by_date.first(4)
    @posts = Post.order_by_date.first(3)
  end

  def discussion

  end

  def selected
    @videos=Video.selected.first(20)
  end

  def mobile
    @shops = Shop.order_by_update.first(4)
    @videos = Video.order_by_date.first(4)
    @posts = Post.order_by_date.first(3)
  end

  def popular
    if params[:number]
      number = params[:number].to_i
    else
      number = 7
    end
    @videos = Video.created_in_days(number).order_by_hits.first(4)
    @posts =  Post.created_in_days(number).order_by_likes.first(2) +Post.created_in_days(number).order_by_reply_number.first(2)
    @items = Item.order_by_sales.to_a.uniq {|p| p.shop_id}[0..3]

  end
end
