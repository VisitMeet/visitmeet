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
class Product < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 160 }
  validates :price, numericality: { less_than_or_equal_to: 300 } # TODO: WHY such a low $20 LIMIT ??

  enum category: [:Food, :Travelling, :Lodging, :Shopping]

  belongs_to :user
  belongs_to :category

  geocoded_by :location
  after_validation :geocode

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
