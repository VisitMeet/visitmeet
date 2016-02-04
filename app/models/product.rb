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
  enum category: [:Food, :Travelling, :Lodging, :Shopping]
  belongs_to :user
  has_one :category
  geocoded_by :location
  after_validation :geocode
end
