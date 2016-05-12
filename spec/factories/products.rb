# frozen_string_literal: true
# code: spec/factories/products.rb
# test: spec/products/products_spec.rb
#
# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  price              :integer
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category           :integer
#  category_id        :integer
#  latitude           :float
#  longitude          :float
#  location           :string
#  image              :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime

FactoryGirl.define do
  factory :product do
    title 'AWARENESS'
    description 'Star Art of Awareness'
    price 1900
    category 3
    category_id 4
    latitude 44.05396
    longitude '-123.09273'.to_f
    location ''
    image ''
    image_file_name 'awareness-snowflame-thumb.jpg'
    image_content_type 'image/jpg'
    image_file_size nil
    image_updated_at nil
  end
end
