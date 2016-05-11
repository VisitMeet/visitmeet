# frozen_string_literal: true
# code: spec/factories/products.rb
# test: spec/products/products_spec.rb
#
# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category    :integer
#  latitude    :float
#  longitude   :float
#  location    :string
#  category_id :integer
#
FactoryGirl.define do
  factory :product do
    title 'AWARENESS'
    description 'Star Art of Awareness'
    price 1900
    category 3
    latitude 44.05396
    longitude (-123.09273)
    location ''
  end
end
