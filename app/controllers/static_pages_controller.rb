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

  def cafe_digest
    if !params[:category].blank?
      posts = Post.by_category(params[:category])
    else
      posts = Post.by_forum('cafe')
    end

    if params[:sort] == 'like'
      posts = posts.order_by_likes
    elsif params[:sort] == 'reply'
      posts = posts.order_by_reply_number
    else
      posts = posts.order_by_date
    end
    @posts = posts.paginate(:page => params[:page], :per_page => 10)
  end

  def selected
    @videos=Video.selected.paginate(:page => params[:page])
  end

  def mobile
    @shops = Shop.order_by_update.first(4)
    @videos = Video.order_by_date.first(4)
    @posts = Post.order_by_date.first(3)
  end

  def popular
    base_videos = Video.by_source('youtube')
    base_posts = Post.by_forum('cafe')
    if params[:sort]
      @videos = base_videos.order_by_date.first(4)
      @posts = base_posts.order_by_date.first(5)
    else
      if params[:number]
        number = params[:number].to_i
      else
        number= 7
      end
      selected_video = base_videos.selected.updated_in_days(number).first
      trending_videos = base_videos.where(selected: false).created_in_days(number).order_by_rating.first(3)
      @videos =  trending_videos.unshift(selected_video)
      @posts =  base_posts.created_in_days(number).order_by_likes.first(5)
    end
  end

  def admin

  end

  def resources
    @shops = Shop.all
    @youku_sites = RESOURCES_CONSTANT::YOUKU
    @forums = RESOURCES_CONSTANT::FORUMS
    @china_websites = RESOURCES_CONSTANT::CHINA
    @weibos = [
        {url:'http://weibo.com/luchenmagic', name: "刘谦", avatar_url: 'http://tp4.sinaimg.cn/1271542887/180/5682525508/1'},
        {url:'http://weibo.com/yifmagic', name: 'Yif',  avatar_url: 'http://tp1.sinaimg.cn/2480681624/180/5707479662/1'},
        {url:'http://weibo.com/dengnanzi', name: '邓男子',  avatar_url: 'http://tp3.sinaimg.cn/1614012094/180/5683480371/1'},
        {url:'http://weibo.com/SomethingMagic', name: 'SomethingMagic',  avatar_url: 'http://tp1.sinaimg.cn/3189082924/180/5674373734/1'},
        {url:'http://weibo.com/tmw9', name: 'TheMagicWay',  avatar_url: 'http://tp1.sinaimg.cn/2232187404/180/40000949813/1'},
    ]
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
