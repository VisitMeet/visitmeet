# frozen_string_literal: true
class AddCategoriesToProduct < ActiveRecord::Migration
  def change
    add_column :products, :category, :integer
  end
end
