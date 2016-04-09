# frozen_string_literal: true
# spec/routing/users_routing_spec.rb
require 'pry'
describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to root_path' do
      expect(get('visitors/index')).to route_to('visitors#index')
    end

    # tests app/views/profile/index.html.slim 
    it 'routes to profile#index' do
      expect(get('/profile/index')).to route_to('profile#index')
    end

    # tests app/views/profile/user
    it 'routes to users#profile' do
      expect(get('/users/profile')).to route_to('users#profile')
    end

    # tests new_user_session
    it 'routes to users#login' do
      expect(get('/users/login')).to route_to('devise/sessions#new')
    end

    it 'routes to products/show#index' do
      pending 'needs work to pass'
      expect(get('products/show[:index]')).to route_to('products/show#index')
    end

    it 'routes to DashboardManifest::ROOT_DASHBOARD, action: :index admin_products/show/#index' do
      user = FactoryGirl.create(:user, email: 'dashboard@example.com')
      user.role = 'admin'
      user.save!
      expect(User.last.persisted?).to be true
      FactoryGirl.create(:product)
      expect(User.first).not_to eq nil
      expect(User.first.role).to eq 'admin'
      expect(Product.first).not_to eq nil
      expect(get(admin_product_path[:index])).to route_to('admin/products/show#index')
      # expect(get(admin_product_path[:id])).to route_to('controller: 'admin/products', action: 'show', id: 'index')
      # expect(get('admin/products/show#index')).to route_to('admin/products/show#index')
    end

    it 'routes to products#index' do

      expect(get('products#index')).to route_to('products#index')
    end

    it 'routes to user#omniauth_callbacks' do
      pending 'needs work to pass'
      expect(get('user#omniauth_callbacks')).to route_to('user/omniauth_callbacks')
    end
  end
end
