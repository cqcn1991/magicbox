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
    else
      @videos = base_videos.order_by_date.first(4)
      @posts = base_posts.order_by_update.first(5)
    end
  end

  def admin

  end

  def resources
    @oversea_shops = RESOURCES_CONSTANT::OVERSEA_SHOPS

    tv_famous_magicians = RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:tv_famous_magicians]
    archives = RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:archives]
    award_winning_magicians = RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:award_winning_magicians]
    @youtube_channels = [tv_famous_magicians, award_winning_magicians, archives, ]

    @oversea_sites = [
#社区类
{url:'http://www.themagiccafe.com/forums/index.php', name: 'themagiccafe'},
#内容类
{url:'http://itricks.com/news/', name: 'iTricks'},
{url:'http://secretartjournal.com/', name: 'Secret Journal'},
{url:'http://www.michaelvincentmagic.com/news', name: 'Elegant Deceptions', favicon:'http://www.michaelvincentmagic.com/favicon.ico'},
{url:'http://www.conjuringarchive.com/', name: "Denis Behr's Conjuring Archive", favicon: 'http://www.conjuringarchive.com/images/favicon.ico'},
{url:'http://conjuringarts.org/', name: 'Conjuring Arts Research Center',favicon: 'http://conjuringarts.org/wp-content/themes/lifestyle_40/images/favicon.ico'},
{url:'http://geniimagazine.com/', name: 'Genii Magazine'},
{url:'http://www.magicmagazine.com/', name: 'Magic Magazine',favicon:'http://www.magicmagazine.com/favicon.ico'},
{url:'http://www.reelmagicmagazine.com/', name: 'Reel Magic Magazine',favicon: 'http://www.reelmagicmagazine.com/templates/reelmagicjoom25a/favicon.ico'},
    ]
  end



end
