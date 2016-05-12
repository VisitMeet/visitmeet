# frozen_string_literal: true
# app/models/shopping_cart_item.rb
# tests: spec/models/shopping_cart_item_spec.rb
#
class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item
end
