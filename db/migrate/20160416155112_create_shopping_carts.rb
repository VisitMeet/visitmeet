# frozen_string_literal: true
class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.timestamps null: false
    end
  end
end
