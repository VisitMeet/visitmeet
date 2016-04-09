# frozen_string_literal: true
# db/migrate/20160118081841_create_products.rb
# db/migrate/20160203171325_add_categories_to_product.rb
# db/migrate/20160204160517_add_latitude_longitude_location_to_products.rb
# db/migrate/20160304162257_add_category_id_to_products.rb
# db/migrate/20160304163929_remove_category_from_products.rb
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
