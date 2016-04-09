# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' + user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
Category.create(name: 'Fooding')
Category.create(name: 'Lodging')
Category.create(name: 'Travelling')
Category.create(name: 'Shopping')

Product.create(
  title: 'AWARENESS',
  description: 'Star Art of Awareness',
  price: 1900, # prices are in cents for Stripe
  latitude: 44.05396,
  longitude: -123.09273,
  location: ''
)
Product.create(title: 'Fishing', description: 'Fishing in home', price: 1500)
Product.create(title: 'Paneer Pakoda with Tea', description: 'Paneer Pakoda with Tea', price: 2000)
Product.create(title: 'Local Chicken Curry', description: 'Local Chicken Curry in Nepali Style', price: 2500)
Product.create(title: 'Pork Kachol', description: 'Steamed Pork mixed with Nepali masalas.', price: 3000)

product = Product.first
puts 'Product Title: ' + product.title.to_s
puts 'Product Price: ' + product.price.to_s
puts 'Product Description: ' + product.description.to_s
puts 'Product Latitude: ' + product.latitude.to_s
puts 'Product Longitude: ' + product.longitude.to_s
puts 'Four more products have been created'
