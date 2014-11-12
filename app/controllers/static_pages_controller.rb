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

  def selected
    @videos=Video.selected.paginate(:page => params[:page])
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
    @posts = @posts.uniq
    @items = Item.order_by_sales.to_a.uniq {|p| p.shop_id}[0..3]
  end

  def admin

  end

  def resources
    @shops = Shop.all
    @youku_sites = [{url: 'UMTAyMDY5MTE2', name: 'derren brown'},
                   {url: 'UMzU5NjcwNzk2',name: 'themagicway'},
                   {url: 'UMTQ0ODgzOTQ0',name: '张笑我'},
                   {url:'UMTg1MzM3MzMy',name: 'E-Chong'},
                   {url:'UNTc0MDYxNjcy',name: 'SomethingMagic'},
                   {url: 'UMTQzNDg2NzU2', name: '现实一种'},
                   {url: 'UMjUyNDczNTA4', name: '竹音牵梦'},
                   {url:'UNDI2NjE2MzI=', name: 'cheunglei'},
                   {url:'UMTU1Nzg4MzA0', name: '兰色死鱼'},
                   {url:'UMjQ4MjgyMjEy', name: '禾小口'},
                   {url:'UMTg1NTc5ODgw', name: '酒精一百二十度'},
                   {url:'UMzY0OTU2ODgw', name: '酒精百分一百二'},
                   {url:'UMTI5MzQyMTQw', name: '哈利波特魔术'},
                   {url:'UNTAwMjg4Njg=', name: 'ArtherChan'}]
    @forums = [
              {url:'http://www.superx.org/bbs/forum.php', name: '魔术吧 超人联盟'},
              {url:'http://www.collegemagic.cn/forum.php', name: '高校魔术'},
              {url:'http://tieba.baidu.com/f?kw=%C4%A7%CA%F5', name: '百度魔术吧'},
              {url:'http://tieba.baidu.com/f?kw=%D0%C4%C1%E9%C4%A7%CA%F5', name: '百度心灵魔术吧'},
              {url:'http://tieba.baidu.com/f?kw=%BB%A8%C7%D0', name: '百度花式吧'},]
    @china_website = []
    @overseas = [
#社区类
{url:'http://www.themagiccafe.com/forums/index.php', name: 'themagiccafe'},
#魔术厂商类
{url:'http://murphysmagic.com', name: "Murphy's Magic"},
{url:'http://www.penguin.com', name: 'Penguin Magic'},
{url:'http://www.dananddave.com', name: 'Dan and Dave'},
{url:'http://www.ellusionist.com', name: 'Ellusionist'},
{url:'http://www.theory11.com', name: 'Theory11'},
{url:'http://www.vanishingincmagic.com', name: 'Vanishing Inc.'},
{url:'http://www.ementalism.com', name: 'Ementalism'},
{url:'http://www.lybrary.com/', name: 'lybrary'},
{url:'http://www.alakazam.co.uk/', name: 'Alakazam Magic'},
{url:'http://www.bigblindmedia.com/', name: 'Big Blind Media'},
#内容类
{url:'http://secretartjournal.com/', name: 'Secret Journal'},
{url:'http://www.conjuringarchive.com/', name: 'The Conjuring Archive'},
{url:'http://conjuringarts.org/', name: 'Conjuring Arts Research Center'},
{url:'http://geniimagazine.com/', name: 'Genii Magazine'},
{url:'http://www.magicmagazine.com/', name: 'Magic Magazine'},
{url:'http://www.reelmagicmagazine.com/', name: 'Reel Magic Magazine'},
    ]
  end
end
