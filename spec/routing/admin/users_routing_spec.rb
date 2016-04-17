# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routing/admin/users_routing_spec.rb
require 'pry'
module Admin
  describe Admin::UsersController, type: :routing do
    include Warden::Test::Helpers

    before(:each) do
      @user = FactoryGirl.create(:user, email: 'dashboard@example.com')
      @user.role = 'admin'
      @user.save!
      @user = User.last
    end

    after(:each) do
      Warden.test_reset!
    end

    describe 'routing' do
      it 'routes to root_path' do
        expect(get('visitors/index')).to route_to('visitors#index')
      end

      it 'routes to root_path' do
        # Returns a hash of attributes that can be used to build a User instance
        attrs = FactoryGirl.attributes_for(:user, email: 'attributed@example.com')
        @user = FactoryGirl.build(:user, attrs)
        @user.role = 'admin' # using Enum for roles
        @user.save!
        expect(@user.persisted?).to eq true

        @users = User.all
        expect(get('visitors/index')).to route_to('visitors#index')
      end

      it 'routes to DashboardManifest::ROOT_DASHBOARD, action: :index admin/users#index' do
        expect(User.last.persisted?).to be true
        expect(User.first).not_to eq nil
        expect(User.first.role).to eq 'admin'
        expect(@user.admin?).to eq true

        # get '/admin/users' # fails with nil
        visit admin_users_path
        expect(current_path).to eq '/admin/users'
        expect(page).to have_content 'dashboard@example.com'
        expect(page).to have_current_path(admin_users_path)
        expect(get(admin_users_path)).to route_to(controller: 'admin/users', action: 'index')
        expect(get(admin_products_path)).to route_to(controller: 'admin/products', action: 'index')
      end
    end
  end
end
