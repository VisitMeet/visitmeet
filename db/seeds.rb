# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
Rails::Logger.info 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
Product.create(
  title: 'AWARENESS',
  description: 'Star Art of Awareness',
  price: 19,
  user_id: 1,
  category: 'Shopping',
  category_id: 4,
  latitude: 44.05396,
  longitude: -123.09273,
  location: ''
)
product = Product.first
Rails::Logger.info product.title.to_s
Rails::Logger.info product.category.to_s
Rails::Logger.info product.price.to_s
Rails::Logger.info product.user_id.to_s
Rails::Logger.info product.description.to_s
Rails::Logger.info product.latitude.to_s
Rails::Logger.info product.longitude.to_s

# Product.create(title: 'Product 1', description: 'Description', price: 33, user_id: 1, category: 'Food')
# Product.create(title: 'Product 1', description: 'Description', price: 33, user_id: 1, category: 'Food')
# Product.create(title: 'Product 1', description: 'Description', price: 33, user_id: 1, category: 'Food')
# Product.create(title: 'Product 1', description: 'Description', price: 33, user_id: 1, category: 'Food')
