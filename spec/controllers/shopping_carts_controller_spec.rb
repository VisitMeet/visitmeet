# frozen_string_literal: true
# code: app/controllers/shopping_carts_controller.rb
# test: spec/controllers/shopping_carts_controller_spec.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
# NOTE: these tests are just begun : 20160424 -ko
#
# #              Prefix | Verb    | URI Pattern                       | Controller#Action
# # shopping_cart_index | GET     | /shopping_cart(.:format)          | shopping_cart#index
# #                     | POST    | /shopping_cart(.:format)          | shopping_cart#create
# #   new_shopping_cart | GET     | /shopping_cart/new(.:format)      | shopping_cart#new
# #  edit_shopping_cart | GET     | /shopping_cart/:id/edit(.:format) | shopping_cart#edit
# #       shopping_cart | GET     | /shopping_cart/:id(.:format)      | shopping_cart#show
# #                     | PATCH   | /shopping_cart/:id(.:format)      | shopping_cart#update
# #                     | PUT     | /shopping_cart/:id(.:format)      | shopping_cart#update
# #                     | DELETE  | /shopping_cart/:id(.:format)      | shopping_cart#destroy
#
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe ShoppingCartsController, :devise, js: true do
  render_views

  before(:each) do
    @user = FactoryGirl.build(:user, email: 'shopping@example.com')
    @user.role = 'user' # using Enum for roles
    @user.save!
    login_as(@user, scope: :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'ShoppingCart' do
    context 'without items' do
      it 'exists' do
        expect(response.status).to eq 200
        expect(response).to be_success
      end
    end

    context 'with items' do
      it 'renders the shopping cart view for User' do
        pending 'write the code we wish we had'
        get :index
        expect(response.status).to eq 200
        expect(response).to be_success
        expect(current_path).to eq '/shopping_carts/show'
      end

      it 'has shopping cart items in it' do
        pending 'needs more work to work'
        get :show
        # get :show
        # ActionController::UrlGenerationError:
        #  No route matches {:action=>"show", :controller=>"shopping_carts"}
        expect(shopping_cart_item.owner_id).to eq ''
        expect(shopping_cart_item.owner_type).to eq ''
        expect(shopping_cart_item.quantity).to eq 1
        expect(shopping_cart_item.item_id).to eq 1
        expect(shopping_cart_item.item_type).to eq ''
        expect(shopping_cart_item.price.class).to eq Integer
        expect(shopping_cart_item.price).not_to eq nil
      end
    end
  end
end
