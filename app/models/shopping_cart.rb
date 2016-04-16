class ShoppingCart < ActiveRecord::Base
  acts_as_shopping_cart


  # over ride the default tax percentage.
  def tax_pct
    20
  end
end
