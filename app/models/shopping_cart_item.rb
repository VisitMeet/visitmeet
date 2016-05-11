# frozen_string_literal: true
# Shopping cart item class.
class ShoppingCartItem < ActiveRecord::Base
  acts_as_shopping_cart_item
end
