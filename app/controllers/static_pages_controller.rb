# encoding: utf-8
class StaticPagesController < ApplicationController

  def home
    #@shops = Shop.order_by_update.first(4)
    @items = Item.order_by_date.to_a.uniq {|p| p.shop_id}[0..7]
    @videos = Video.order_by_date.first(4)
    @posts = Post.order_by_date.first(3)
  end

  def discussion
  end

  def nodes
    @nodes = RESOURCES_CONSTANT::NODES
  end

  def selected
  end

  def mobile
    @shops = Shop.order_by_update.first(4)
    @videos = Video.order_by_date.first(4)
    @posts = Post.order_by_date.first(3)
  end

  def popular
    base_videos = Video.by_source('youtube')
    base_posts = Post.by_forum('cafe')
    if !(params[:number] or params[:sort])
      params[:sort] = 'new'
    end
    if  params[:number]
      number = params[:number].to_i
      trending_videos = base_videos.created_in_days(number).order_by_rating.first(4)
      @videos =  trending_videos
      @posts =  base_posts.created_in_days(number).order_by_likes.first(5)
    elsif params[:sort] == 'new'
      @videos = base_videos.order(created_at: :desc).first(4)
      @posts = base_posts.order(created_at: :desc).first(5)
    end
  end

  def admin

  end

  def resources
    @general_websites = RESOURCES_CONSTANT::GENERAL_WEBSITES
    @oversea_shops = RESOURCES_CONSTANT::OVERSEA_SHOPS

    @youtube_channels = []
    RESOURCES_CONSTANT::YOUTUBE_CHANNELS.first(3).each do |key, value|
      @youtube_channels = @youtube_channels.push(value)
    end


  end



end
