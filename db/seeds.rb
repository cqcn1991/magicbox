# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

taobao_sites = ['tccrew.taobao.com', 'tfmmagic.taobao.com', 'magicmine.taobao.com' ,'themagicway.taobao.com',
                'secretfactory.taobao.com', 'collegemagiccollection.taobao.com' ]

taobao_sites.each do |site|
  Shop.create(url: site)
end