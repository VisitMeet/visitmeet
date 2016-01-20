# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  product_id  :integer
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :category do
    products nil
name "MyString"
description "MyText"
  end

end
