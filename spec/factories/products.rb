# frozen_string_literal: true
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
#  category_id :integer
#  latitude    :float
#  longitude   :float
#  location    :string
#
FactoryGirl.define do
  factory :product do
    title 'MyString'
    description 'MyText'
    price 100
    category 1
    category_id 0
    latitude 42.0941
    longitude -125.0941
    location ''
  end
end
