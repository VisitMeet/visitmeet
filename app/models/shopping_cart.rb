# frozen_string_literal: true
# code: app/models/shopping_cart.rb
# test: spec/models/shopping_cart_spec.rb
#
class ShoppingCart < ActiveRecord::Base
  acts_as_shopping_cart

  # over ride the default tax percentage.
  def tax_pct
    20
  end
end
