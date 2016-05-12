# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routing/products_routing_spec.rb
RSpec.configure do
  include Warden::Test::Helpers
end
Warden.test_mode!

# Feature: Products routing
#   As an administrator
#   I want to test products and product routings
#   So I can verify our product routes
describe ProductsController, type: :routing do
  before(:each) do
    FactoryGirl.reload
    @product = FactoryGirl.create(:product)
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'Products routing' do
    it 'routes to products_path' do
      expect(get(products_path)).to route_to('products#index')
    end

    it 'routes to individual product' do
      visit "/products/#{@product.id}"
      expect(current_path).to eq '/products/2'

      product = FactoryGirl.create(:product)
      visit "/products/#{product.id}"
      expect(current_path).to eq '/products/3'
      expect(page).to have_current_path(product_path(product))

      product = Product.last
      expect(page).to have_current_path(product_path(product))
      expect(page.current_path).to eq(product_path(product))
      expect(page.current_path).to eq(product_path(product.id))
    end

    it 'routes to admin/products#index' do
      expect(get('admin/products#index')).to route_to('admin/products#index')
    end

    it 'routes to DashboardManifest::ROOT_DASHBOARD, action: :index admin_products/show/#index' do
      user = FactoryGirl.build(:user, email: 'dashboard@example.com')
      user.role = 'admin'
      user.save!
      expect(User.last.persisted?).to be true
      expect(User.first).not_to eq nil
      expect(User.first.role).to eq 'admin'
      expect(User.last).to eq User.first
      expect(get(admin_products_path)).to route_to(controller: 'admin/products', action: 'index')
    end
  end
end
