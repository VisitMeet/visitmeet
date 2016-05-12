# frozen_string_literal: true
# code: app/models/product.rb
# tests: spec/models/product_spec.rb
#
# Migrations
#
# db/migrate/20160115121043_devise_create_users.rb
# db/migrate/20160115121047_add_name_to_users.rb
# db/migrate/20160115121051_add_confirmable_to_users.rb
# db/migrate/20160115121058_add_role_to_users.rb
# db/migrate/20160115121151_devise_invitable_add_to_users.rb
# db/migrate/20160118081841_create_products.rb
# db/migrate/20160125172412_add_omniauth_to_users.rb
# db/migrate/20160303161926_create_profiles.rb
#
# == Schema Information
#
# Table name: products : last verified accurate 20160417 -ko
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
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#
class Product < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 160 }
  validates :price, numericality: { less_than_or_equal_to: 999_999_00 } # stripe limit is 99999999 in cents
  validates :price, numericality: { greater_than_or_equal_to: 98 } # minimum in cents in US currency

  enum category: [:Foods, :Travels, :Lodges, :Shops]

  belongs_to :user
  belongs_to :category

  geocoded_by :location
  after_validation :geocode

  has_attached_file :image
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
end
