# frozen_string_literal: true
# app/models/category.rb
# spec/models/category_spec.rb
#
# Migrations involved
#
# db/migrate/20160118081841_create_products.rb
# db/migrate/20160203171325_add_categories_to_product.rb
# db/migrate/20160304162257_add_category_id_to_products.rb
# db/migrate/20160304163929_remove_category_from_products.rb
# db/migrate/20160304162459_create_categories.rb
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
class Category < ActiveRecord::Base
  has_many :products
end
