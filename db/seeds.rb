# frozen_string_literal: true
# code: db/seeds.rb
# test: $ bundle exec rake db:reset
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Environment variables (ENV['...']) can be set in the file config/application.yml
# See http://railsapps.github.io/rails-environment-variables.html
#
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' + user.email

Category.create(name: 'Foods')
Category.create(name: 'Lodges')
Category.create(name: 'Travels')
Category.create(name: 'Shops')
puts 'Your available CATEGORIES are: Foods, Lodges, Travels, Shops'

Product.create(
  title: 'AWARENESS',
  description: 'Star Art of Awareness',
  price: 1900, # prices are in cents for Stripe
  user_id: 1,
  category: 'Shops',
  category_id: 4,
  latitude: 44.05396,
  longitude: -123.09273,
  location: ''
)
Product.create(title: 'Fish', description: 'Fish Home Cooked by the Sea', price: 150_00)
Product.create(title: 'Paneer Pakoda with Tea', description: 'Paneer Pakoda with Tea', price: 20_00)
Product.create(title: 'Local Chicken Curry', description: 'Local Chicken Curry in Nepali Style', price: 25_00)
Product.create(title: 'Pork Kachol', description: 'Steamed Pork mixed with Nepali masalas.', price: 30_00)
Product.create(title: 'Supporting Part in Documentary',
               description: 'You can support the filmings of an ongoing research documentary, and appear in it if you wish, in a supporting role',
               category: 'Travels',
               category_id: 2,
               price: 35_000_00
              )
product = Product.first
puts 'the first Offer is an extremely unique art of AWARENESS, created in a new art form specifically for VisitMeet'
puts 'title       : ' + product.title
puts 'price       : ' + product.price.to_s
puts 'description : ' + product.description
puts 'latitude    : ' + product.latitude.to_s
puts 'longitude   : ' + product.longitude.to_s

product = Product.second
puts 'the second Offer is a day long home cooked fish feast by the sea, all food and drink provided, $150.00 US.'
puts 'title       : ' + product.title
puts 'price       : ' + product.price.to_s
puts 'description : ' + product.description
puts 'latitude    : ' + product.latitude.to_s
puts 'longitude   : ' + product.longitude.to_s

product = Product.third
puts 'the third Offer, Paneer Pakoda with Tea'
puts 'title       : ' + product.title
puts 'price       : ' + product.price.to_s
puts 'description : ' + product.description
puts 'latitude    : ' + product.latitude.to_s
puts 'longitude   : ' + product.longitude.to_s

product = Product.fourth
puts 'the fourth Offer, Chicken Curry Nepali Style'
puts 'title       : ' + product.title
puts 'price       : ' + product.price.to_s
puts 'description : ' + product.description
puts 'latitude    : ' + product.latitude.to_s
puts 'longitude   : ' + product.longitude.to_s

product = Product.fifth
puts 'the fifth Offer, Steamed Pork Kachol with Nepali masalas: masalas are our home grown ground spices'
puts 'title       : ' + product.title
puts 'price       : ' + product.price.to_s
puts 'description : ' + product.description
puts 'latitude    : ' + product.latitude.to_s
puts 'longitude   : ' + product.longitude.to_s

product = Product.find(6)
puts 'the sixth Offer, You can support and if you wish, be in a documentary about something new on earth.'
puts 'title       : ' + product.title
puts 'price       : ' + product.price.to_s
puts 'description : ' + product.description
puts 'latitude    : ' + product.latitude.to_s
puts 'longitude   : ' + product.longitude.to_s

puts 'Your development database now has six products and one admin user.'
puts 'Your test database has nothing in it until your tests create items.'
puts 'Your local production database should never have anything in it.'
puts 'To run this app in local production on your own machine, clone the app, use the clone.'
