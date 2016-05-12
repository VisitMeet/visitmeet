# frozen_string_literal: true
# Add image to products
class AddImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image, :string
  end
end
