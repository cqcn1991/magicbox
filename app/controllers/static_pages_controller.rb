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

  def best_in_cafe_2014
    start_time = Date.new(2014,1,1)
    end_time = Date.new(2015,1,1)
    posts = Post.where("created_at >= ? AND created_at < ?", start_time, end_time).order_by_reply_number.first(50)
    @posts = posts
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
    @shops = Shop.all
    @youku_sites = RESOURCES_CONSTANT::YOUKU
    @forums = RESOURCES_CONSTANT::FORUMS
    @china_websites = RESOURCES_CONSTANT::CHINA

    @tv_famous_magicians = RESOURCES_CONSTANT::YOUTUBE_CHANNELS[:tv_famous_magicians]
    @oversea_shops = [#魔术厂商类
        {url:'http://murphysmagic.com/', name: "Murphy's Magic", favicon: 'http://www.murphysmagic.com/favicon1.ico'},
        {url:'http://www.penguin.com/', name: 'Penguin Magic',  favicon: 'http://www.penguinmagic.com/favicon.ico'},
        {url:'http://www.dananddave.com/', name: 'Dan and Dave',favicon: 'http://dananddave.com/wp-content/themes/dananddave/img/favicon.ico' },
        {url:'http://www.ellusionist.com/', name: 'Ellusionist', favicon: 'http://www.ellusionist.com/favicon.ico'},
        {url:'http://www.theory11.com/', name: 'Theory11', favicon: 'http://www.theory11.com/favicon.ico'},
        {url:'http://www.vanishingincmagic.com/', name: 'Vanishing Inc.', favicon: 'http://www.vanishingincmagic.com/favicon.ico'},
        {url:'http://www.ementalism.com/', name: 'Ementalism', favicon: ''},
        {url:'http://www.lybrary.com/', name: 'lybrary', favicon: 'http://www.lybrary.com/favicon.ico'},
        {url:'http://www.alakazam.co.uk/', name: 'Alakazam Magic', favicon: 'http://www.alakazam.co.uk/favicon.ico'},
        {url:'http://thebluecrown.com/', name: 'The Blue Crown', favicon: 'http://thebluecrown.com/favicon.ico'}]
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
