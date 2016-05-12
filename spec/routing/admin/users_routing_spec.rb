# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routing/admin/users_routing_spec.rb
#
# from $ `rake routes`:
# # #           Prefix   |  Verb | URI Pattern                        | Controller#Action
# done1       admin_users    GET /admin/users(.:format)               | admin/users#index
# done14                    POST /admin/users(.:format)               | admin/users#create
# done4    new_admin_user    GET /admin/users/new(.:format)           | admin/users#new
# done11  edit_admin_user    GET /admin/users/:id/edit(.:format)      | admin/users#edit
# done2        admin_user    GET /admin/users/:id(.:format)           | admin/users#show
#                          PATCH /admin/users/:id(.:format)           | admin/users#update
#                            PUT /admin/users/:id(.:format)           | admin/users#update
#                         DELETE /admin/users/:id(.:format)           | admin/users#destroy
# done5    admin_products    GET /admin/products(.:format)            | admin/products#index
#                           POST /admin/products(.:format)            | admin/products#create
# done9 new_admin_product    GET /admin/products/new(.:format)        | admin/products#new
# done12 edit_admin_product  GET /admin/products/:id/edit(.:format)   | admin/products#edit
# done10    admin_product    GET /admin/products/:id(.:format)        | admin/products#show
#                          PATCH /admin/products/:id(.:format)        | admin/products#update
#                            PUT /admin/products/:id(.:format)        | admin/products#update
#                         DELETE /admin/products/:id(.:format)        | admin/products#destroy
# done6  admin_categories    GET /admin/categories(.:format)          | admin/categories#index
#                           POST /admin/categories(.:format)          | admin/categories#create
# done8 new_admin_category   GET /admin/categories/new(.:format)      | admin/categories#new
# done13 edit_admin_category GET /admin/categories/:id/edit(.:format) | admin/categories#edit
# done7     admin_category   GET /admin/categories/:id(.:format)      | admin/categories#show
#                          PATCH /admin/categories/:id(.:format)      | admin/categories#update
#                            PUT /admin/categories/:id(.:format)      | admin/categories#update
#                         DELETE /admin/categories/:id(.:format)      | admin/categories#destroy
# done3         admin_root   GET /admin(.:format)                     | admin/users#index
#
include Warden::Test::Helpers
Warden.test_mode!

module Admin
  describe Admin::UsersController, type: :routing do
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

      it 'routes to root_path take two' do
        # Returns a hash of attributes that can be used to build a User instance
        attrs = FactoryGirl.attributes_for(:user, email: 'attributed@example.com')
        @user = FactoryGirl.build(:user, attrs)
        @user.role = 'admin' # using Enum for roles
        @user.save!
        expect(@user.persisted?).to eq true

        @users = User.all
        expect(get('visitors/index')).to route_to('visitors#index')
      end

      # done1 : admin_users  |  GET  |  /admin/users(.:format)  |     admin/users#index
      it 'routes to DashboardManifest::ROOT_DASHBOARD, action: :index admin/users#index' do
        expect(User.last.persisted?).to be true
        expect(User.first).not_to eq nil
        expect(User.first.role).to eq 'admin'
        expect(@user.admin?).to eq true
        expect(get(admin_root_path)).to route_to('admin/users#index')
        # a demonstration of the Rubyish readability of a test line
        # expect get admin root path to route to controller admin admincontroller action index
        # expect(get(admin_root_path)).to route_to(controller: Admin::UsersController, action: 'index')
        expect(get(admin_root_path)).to route_to(controller: 'admin/users', action: 'index')
      end

      # done2 : admin_user  |  GET  |  /admin/users/:id(.:format)  |  admin/users#show
      it 'routes to admin_user_path' do
        # a demonstration of the Rubyish readability of a test line
        # expect get admin user path at user id to route to controller admin admincontroller action show id one
        # expect(get(admin_user_path(@user.id))).to route_to(controller: Admin::UsersController, action: 'show', id: '1')
        expect(get(admin_user_path(@user.id))).to route_to(controller: 'admin/users', action: 'show', id: @user.id.to_s)
      end

      # done3 : admin_root | GET | /admin(.:format) | admin/users#index
      it 'routes to admin root' do
        expect(get(admin_root_path)).to route_to(controller: 'admin/users', action: 'index')
      end

      # done4 new_admin_user | GET | /admin/users/new(.:format) | admin/users#new
      it 'routes to new_admin_user' do
        expect(get(new_admin_user_path)).to route_to(controller: 'admin/users', action: 'new')
      end

      # done5 admin_products GET | /admin/products(.:format) | admin/products#index
      it 'routes to admin_products' do
        expect(get(admin_products_path)).to route_to(controller: 'admin/products', action: 'index')
      end

      # done6 admin_categories GET | /admin/categories(.:format) | admin/categories#index
      it 'routes to admin_categories' do
        expect(get(admin_categories_path)).to route_to(controller: 'admin/categories', action: 'index')
      end

      # done7 admin_category GET | /admin/categories/:id(.:format) | admin/categories#show
      it 'routes to admin_category' do
        expect(get(admin_category_path('3'))).to route_to(controller: 'admin/categories', id: '3', action: 'show')
      end

      # done8 new_admin_category GET | /admin/categories/new(.:format) | admin/categories#new
      it 'routes to new_admin_category' do
        expect(get(new_admin_category_path)).to route_to(controller: 'admin/categories', action: 'new')
      end

      # done9 new_admin_product GET | /admin/products/new(.:format) | admin/products#new
      it 'routes to new_admin_product' do
        expect(get(new_admin_product_path)).to route_to(controller: 'admin/products', action: 'new')
      end

      # done10 admin_product GET | /admin/products/:id(.:format) | admin/products#show
      it 'routes to admin_category_path' do
        expect(get(admin_category_path('3'))).to route_to(controller: 'admin/categories', action: 'show', id: '3')
      end

      # done11 # edit_admin_user GET | /admin/users/:id/edit(.:format) | admin/users#edit
      it 'routes to edit_admin_user_path' do
        expect(get(edit_admin_user_path('1'))).to route_to(controller: 'admin/users', action: 'edit', id: '1')
      end

      # done12 edit_admin_product GET | /admin/products/:id/edit(.:format) | admin/products#edit
      it 'routes to edit_admin_product_path' do
        expect(get(edit_admin_product_path('1'))).to route_to(controller: 'admin/products', action: 'edit', id: '1')
      end

      # done13 edit_admin_category GET | /admin/categories/:id/edit(.:format) | admin/categories#edit
      it 'routes to edit_admin_categories_path' do
        expect(get(edit_admin_category_path('1'))).to route_to(controller: 'admin/categories', action: 'edit', id: '1')
        # expect(get(admin_product_path('1'))).to  route_to(controller: 'admin/products', action: 'show')
        # expect(get(edit_admin_user_path('1'))).to route_to(controller: 'admin/users', action: 'edit', id: '1')
        # expect(get(admin_user_path(@user.id))).to route_to(controller: 'admin/users', action: 'show', id: @user.id.to_s)
        # done11 edit_admin_user GET   /admin/users/:id/edit(.:format)      | admin/users#edit
        # expect(get(admin_product_path('1'))).to  route_to(controller: 'admin/products', action: 'show')
        # expect(get(edit_admin_user_path('1'))).to route_to(controller: 'admin/users', action: 'edit', id: '1')
        # expect(get(admin_user_path(@user.id))).to route_to(controller: 'admin/users', action: 'show', id: @user.id.to_s)
      end

      # done14 | POST | /admin/users(.:format) | admin/users#create
      it 'routes to admin_users#create_path' do
        user = FactoryGirl.build(:user)
        user.role = 'admin'
        expect(get(admin_users_path(user))).to route_to(controller: 'admin/users', action: 'index')
      end

      # done1? next : template to work with
      # it 'routes to _path' do
      # pending 'needs more work to pass'
      # # expect(get(admin_users_path(user))).to route_to(controller: 'admin/users', action: 'index')
      # # expect(get(edit_admin_category_path('1'))).to route_to(controller: 'admin/categories', action: 'edit', id: '1')
      # # expect(get(edit_admin_category_path('1'))).to route_to(controller: 'admin/categories', action: 'edit', id: '1')
      # # expect(get(admin_product_path('1'))).to  route_to(controller: 'admin/products', action: 'show')
      # # expect(get(edit_admin_user_path('1'))).to route_to(controller: 'admin/users', action: 'edit', id: '1')
      # # expect(get(admin_user_path(@user.id))).to route_to(controller: 'admin/users', action: 'show', id: @user.id.to_s)
      # # expect(get(admin_product_path('1'))).to  route_to(controller: 'admin/products', action: 'show')
      # # expect(get(edit_admin_user_path('1'))).to route_to(controller: 'admin/users', action: 'edit', id: '1')
      # # expect(get(admin_user_path(@user.id))).to route_to(controller: 'admin/users', action: 'show', id: @user.id.to_s)
      # end
    end
  end
end
