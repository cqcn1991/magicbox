# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

taobao_sites = [{url:'tccrew.taobao.com', name: 'tcc'},
                {url:'tfmmagic.taobao.com', name: 'tfmentalism'},
                {url:'magicmine.taobao.com', name: 'magicmining'},
                {url:'themagicway.taobao.com', name: 'themagicway'},
                {url:'secretfactory.taobao.com', name: '酒精哥'},
                {url:'collegemagiccollection.taobao.com', name:'高校魔术'} ]

taobao_sites.each do |site|
    shop = Shop.new(url: site[:url], name: site[:name])
    if shop.save
      puts site[:name] + 'saved'
    else
      puts site[:name] + 'not saved'
    end
end

Notice.create(content: '10月11日，Howard Hamburg线上讲座,购票链接http://item.taobao.com/item.htm?spm=a1z10.1.w4004-1583697974.3.mMHGr7&id=41257580973')