# encoding: utf-8
require 'json'
require 'digest/sha1'

Dir["./models/*.rb"].each {|file| require file }

Product.delete_all

items = []
items.push :name => '可口可乐', :unit => '瓶', :price => 3.00, :promotion => false, :stock => 20 ,:detail => '美国可口可乐公司生产'
items.push :name => '雪碧', :unit => '瓶', :price => 3.00, :promotion => false, :stock => 20 ,:detail => '美国可口可乐公司生产'
items.push :name => '苹果', :unit => '斤', :price => 5.50, :promotion => false, :stock => 20 ,:detail => '一种营养价值很高的水果'
items.push :name => '荔枝', :unit => '斤', :price => 15.00, :promotion => false, :stock => 0 ,:detail => '顽固性呃逆及五更泻者的食疗佳品'
items.push :name => '电池', :unit => '个', :price => 2.00, :promotion => false, :stock => 20 ,:detail => '南孚电池 一节更比六节强'
items.push :name => '方便面', :unit => '袋', :price => 4.50, :promotion => false, :stock => 1 ,:detail => '康师傅老坛酸菜'

items.each do |item|
puts Product.create(item).to_json
end


Administrator.delete_all

puts Administrator.create(:name => 'admin', :password => Digest::SHA1.hexdigest('admin')).to_json


User.delete_all

puts User.create(:email => '123456@qq.com', :password => Digest::SHA1.hexdigest('123456'), :name => 'cxl', :address => 'xian', :phone => '18392035693').to_json
puts User.create(:email => '298052357@qq.com', :password => Digest::SHA1.hexdigest('123456'), :name => 'SanCoder', :address => 'xian', :phone => '18392035693').to_json
