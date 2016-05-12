# frozen_string_literal: true
# code: app/controllers/products_controller.rb
# test: spec/controllers/products_controller_spec.rb
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
# Indexes on category_id and user_id :
#  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
#  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree
#
# user_id is what links the products purchased to the user purchasing them
# user_id is used to identify/show which user is purchasing what product, and putting in shopping_cart.
#
#  <%= link_to 'Add to cart', shopping_cart_path(product_id: product.id), class: "btn btn-success" %>
#
# Explanation of product_id :
# product_id is what links the products purchased to the user purchasing them ?
# product_id is used to identify/show what product(s) user is placing into cart ?
#
#  <%= link_to 'Add to cart', shopping_cart_path(product_id: product.id), class: "btn btn-success" %>
#
# FOREIGN KEY: add_foreign_key "products", "users"
#
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do
  def setup
    @controller = ProductsController.new
  end
end

describe ProductsController, :devise, type: :controller, controller: true, js: true do
  render_views

  before(:each) do
    @user = FactoryGirl.build(:user, email: 'tester@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
    login_as @user

    @product = FactoryGirl.create(:product, user_id: 1)
    @products = Product.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'GET index' do
    it 'assigns @products' do
      pending 'need to have the user signed in'
      get :index
      expect(assigns(:products)).to eq([product])
    end

    it 'renders the index template' do
      pending 'need to have the user signed in'
      get :index
      expect(response).to render_template 'index'
    end

    it 'has a 200 status code' do
      pending 'need to have the user signed in'
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET #new' do
    it 'is successful' do
      pending 'need to have the user signed in'
      get :new, user_id: @user.id

      # get :new
      # # NoMethodError: undefined method `authenticate!' for nil:NilClass

      # when fixed, uncomment the line below, and remove the line below that
      # expect(response).to render_template 'new'
      expect(response).to render_template '/users/login'
    end

    it 'has a 200 status code' do
      pending 'need to have the user signed in'
      get :new
      expect(response.status).to eq 200
      #
      # get :new
      # expect(response.status).to eq 200 : 20160424
      # # expected: 200
      # #      got: 302
    end
  end

  describe 'POST #create' do
    it 'is successful' do
      pending 'need to have the user signed in'
      post :create, product: { title: 'new_product', price: '20000' } # in cents
      expect(response).to render_template 'show'
    end

    it 'has a 200 status code' do
      pending 'need to have the user signed in'
      @product = Product.last
      get :edit, id: @product.id
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    it 'is successful' do
      pending 'need to have the user signed in'
      @product = Product.last
      get :edit, id: @product.id
      expect(response).to render_template 'edit'
    end

    it 'has a 200 status code' do
      pending 'need to have the user signed in'
      @product = Product.last
      get :edit, id: @product.id
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do
    before(:each) do
      pending 'need to have the user signed in ?'
      @user = FactoryGirl.build(:user)
      @user.role = 'admin'
      @user.save!
    end

    it 'is successful' do
      pending 'need to have the user signed in ?'
      @product = Product.last
      get :show, id: @product.id
      #
      # get :show, @product # fails with ..
      # ActionController::UrlGenerationError:
      #  No route matches {:action=>"show", :controller=>"products"}
    end

    # admin_products | GET | /admin/products(.:format) | admin/products#index
    # it 'routes to DashboardManifest::ROOT_DASHBOARD, action: :index admin_products/show/#index' do
    # # user = FactoryGirl.create(:user, email: 'dashboard@example.com')
    # # user.role = 'admin'
    # # user.save!
    # # expect(User.last.persisted?).to be true
    # # expect(User.first).not_to eq nil
    # # expect(User.first.role).to eq 'admin'
    # #
    # #  visit admin_products_path
    # # visit '/admin/products'
    # # expect(current_path).to eq '/admin/products#index'
    # end

    it 'is notes for tests by kathyonu' do
      pending 'to test the user_id'
      # $ `rails console`
      # product = Product.new
      # product.title = 'artwork'
      # product.description = 'this and that'
      # product.price = 22200
      # product.user_id = 1
      # product.save!
      # (0.5ms)  BEGIN
      # SQL (822.6ms)  INSERT INTO "products" ("title",
      #                                        "description",
      #                                        "price",
      #                                        "user_id",
      #                                        "created_at",
      #                                        "updated_at"
      #                                       ) VALUES ($1, $2, $3, $4, $5, $6)
      # RETURNING "id"  [["title", "artwork"],
      # ["description", "this and that"],
      # ["price", 22200], ["user_id", 1],
      # ["created_at", "2016-05-01 04:14:59.224084"],
      # ["updated_at", "2016-05-01 04:14:59.224084"]]
      # (57.5ms)  COMMIT
      # # => true
      #
    end
  end
end
