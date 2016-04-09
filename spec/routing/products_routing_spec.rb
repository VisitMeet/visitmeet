# frozen_string_literal: true
# spec/routing/products_routing_spec.rb
require 'pry'
describe ProductsController, type: :routing do
  describe 'Products routing' do
    it 'routes to products_path' do
      expect(get('products/show/index')).to route_to('products/show#index')
    end
  end
end
