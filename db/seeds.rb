# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

taobao_sites = [{url:'tccrew.taobao.com', name: 'tcc', avatar_url: 'http://img04.taobaocdn.com/bao/uploaded//fb/e5/T10Z9fXaBwXXb1upjX.jpg_50x50.jpg '},
                {url:'tfmmagic.taobao.com', name: 'tfmentalism',  avatar_url: 'http://img02.taobaocdn.com/bao/uploaded//fe/5e/T1pJzTFi0aXXb1upjX.jpg_50x50.jpg' },
                {url:'magicmine.taobao.com', name: 'magicmining', avatar_url: 'http://img03.taobaocdn.com/bao/uploaded//c2/f4/T1mCvZXnRjXXb1upjX.jpg_50x50.jpg' },
                {url:'themagicway.taobao.com', name: 'themagicway',avatar_url:'http://img01.taobaocdn.com/bao/uploaded//51/a2/T16kqkXgtyXXaCwpjX.png_50x50.jpg '},
                {url:'secretfactory.taobao.com', name: '酒精哥', avatar_url:'http://img03.taobaocdn.com/bao/uploaded//c5/1e/TB1kaxfFVXXXXbWXFXXSutbFXXX.jpg_50x50.jpg '},
                {url:'collegemagiccollection.taobao.com', name:'高校魔术', avatar_url: 'http://img01.taobaocdn.com/bao/uploaded//a5/79/T1eTyTXiJoXXb1upjX.jpg_50x50.jpg '},
                {url:'zhuoyuemagic2010.taobao.com', name:'EPCS', avatar_url:'http://img03.taobaocdn.com/bao/uploaded//d2/70/T1VwJTXaVyXXb1upjX.jpg_50x50.jpg '} ]

taobao_sites.each do |site|
    shop = Shop.new(url: site[:url], name: site[:name])
    if shop.save
      puts site[:name] + 'saved'
    else
      puts site[:name] + 'not saved'
    end
end

Rake::Task["fetch_all"].invoke(30)

#Rake::Task["fetch_popularity"]
Notice.create(content: 'notice 1')
Notice.create(content: '10月11日，Howard Hamburg线上讲座,购票链接http://item.taobao.com/item.htm?spm=a1z10.1.w4004-1583697974.3.mMHGr7&id=41257580973')
Notice.create(content: 'notice 2')
Notice.create(content: 'notice 3')