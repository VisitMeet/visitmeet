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
Category.create(name: 'Fooding')
Category.create(name: 'Lodging')
Category.create(name: 'Travelling')
Category.create(name: 'Shopping')

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
Product.create(title: 'Fishing', description: 'Fishing in home', price: 15)
Product.create(title: 'Paneer Pakoda with Tea', description: 'Paneer Pakoda with Tea', price: 20)
Product.create(title: 'Local Chicken Curry', description: 'Local Chicken Curry in Nepali Style', price: 25)
Product.create(title: 'Pork Kachol', description: 'Steamed Pork mixed with Nepali masalas.', price: 30)

product = Product.first
Rails::Logger.info product.title.to_s
Rails::Logger.info product.category.to_s
Rails::Logger.info product.price.to_s
Rails::Logger.info product.user_id.to_s
Rails::Logger.info product.description.to_s
Rails::Logger.info product.latitude.to_s
Rails::Logger.info product.longitude.to_s
Rails::Logger.info 'Four more products have been created'
