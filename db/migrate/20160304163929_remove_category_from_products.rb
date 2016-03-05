class RemoveCategoryFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :category, :integer
  end
end
