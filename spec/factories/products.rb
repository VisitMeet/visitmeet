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
#  latitude    :float
#  longitude   :float
#  location    :string
#  category_id :integer
#

FactoryGirl.define do
  factory :product do
    title 'MyString'
    description 'MyText'
    price 1
    user nil
  end
end
