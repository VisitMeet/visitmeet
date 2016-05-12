# frozen_string_literal: true
# code: spec/factories/categories.rb
# test: spec/models/categories_spec.rb
#
# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :category do
    name 'Foods'
  end
end
