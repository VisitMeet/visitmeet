# frozen_string_literal: true
class RemoveCategoryFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :category, :integer
  end
end
