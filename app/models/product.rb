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
#  category_id :integer
#
class Product < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 160 }
  validates :price, numericality: { less_than_or_equal_to: 20 } # TODO: WHY such a low $20 LIMIT ??

  enum category: [:Food, :Travelling, :Lodging, :Shopping]

  belongs_to :user
  has_one :category

  geocoded_by :location
  after_validation :geocode
end
