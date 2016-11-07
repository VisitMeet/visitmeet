# frozen_string_literal: true
# code: app/controllers/shopping_cart_controller.rb
# test: spec/controllers/shopping_cart_controller_spec.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
# Shopping Carts controller
class ShoppingCartsController < ApplicationController
  before_action :extract_shopping_cart

  def index
  end

  def create
    @product = Product.find(params[:product_id])
    @shopping_cart.add(@product, @product.price)
    redirect_to shopping_cart_path(@shopping_cart)
  end

  def checkout
    @@customer = Stripe::Customer.create email: stripe_params["stripeEmail"],
                                         card: stripe_params["stripeToken"]

    Stripe::Charge.create customer: @@customer,
                          amount: (@shopping_cart.total * 100).round,
                          description: "Bought by: " + current_user.email,
                          currency: 'usd'
    redirect_to products_path
    flash[:notice] = "Succefully made payment of $" + @shopping_cart.total.to_s
  end

  def show
  end

  private

  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end

  def stripe_params
    params.permit :stripeEmail, :stripeToken
  end
end
