# frozen_string_literal: true
# spec/controllers/users_controller_spec.rb
# tetsting app/controllers/users/users_controller.rb
# run command $ rspec spec/controllers/users/users_controller_spec.rb
# run command $ git diff spec/controllers/users/users_controller_spec.rb
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
#
# Testing troubles? Use Pry: uncomment line below,
# add on a line by itself, the
# `binding.pry` command uncommented,
# and run the test, Pry will open your console.
require 'pry' 
include Devise::TestHelpers
include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do
  def valid_session
    @user = FactoryGirl.build(:user, email: 'newadmin@example.com')
    @user.role = 'admin'
    @user.save
    @valid_session = { user_id: 1 }
  end

  def valid_user_attributes
    @valid_user_attributes = { id: 3, email: 'newadmin@example.com', password: 'please123', password_confirmation: 'please123' }
  end

  def invalid_user_attributes
    @invalid_user_attributes = { id: 6, email: 'newadmin@examplecom', password: 'please12', password_confirmation: 'please123' }
  end
end

RSpec.describe UsersController, :devise, type: :controller, controller: true, js: true do
  # let!(:user) { User.create(email: 'iam@example.com', password: 'please123', password_confirmation: 'please123')
  # let!(:valid_user_attributes) { email: 'iam@example.com', password: 'please123', password_confirmation: 'please123' }
  # let!(:user) { User.create(valid_user_attributes) }

  before(:each) do
    @user = FactoryGirl.build(:user, email: 'test@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
    @users = User.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'has correct attributes' do
        expect(@valid_user_attributes).to be_an Array
      end

      it 'creates a new user' do
        expect { FactoryGirl.create(:user, email: 'newestuser@example.com') }.to change(User, :count).by(1)
        # expect { post :create, 'devise_invitable/registrations': @valid_user_attributes, @valid_session }.to change(User, :count).by(1)
      end
    end

    context 'with valid params' do
      it 'creates a new user' do # f
        expect(User.all.size).to eq 1
        expect {
          post :create, @valid_user_attributes, @valid_session
        }.to change(User, :count).by(1)
      end
        # expect {
        #  post :create, { user: @valid_user_attributes } }.to change(User.all.count).by(1)
        # ActionController::UrlGenerationError:
        #  No route matches {:action=>"create", :controller=>"users", :user=>nil}

        # expect {
        #  post :create, { user: @valid_user_attributes } }.to change(User.all.count).by(1)
        # ArgumentError:
        #  `change` requires either an object and message (`change(obj, :msg)`) or a block (`change { }`). You passed an object but no message.
      # end

      it 'assigns a requested user as @user' do
        @user = FactoryGirl.build(:user, email: 'atuser@example.com')
        @user.role = 'admin'
        @user.save!
 
        @request.env['devise.mapping'] = Devise.mappings[:user]
        signin(@user.email, @user.password)
        expect(current_path).to eq '/'
        expect(page).to have_content 'atuser@example.com'

        visit '/users/profile'
        # expect(response).to respond_to('/users/profile')
        expect(response).to render_template('users/profile')
        expect(current_path).to eq '/users/profile'
        expect(page).to have_content 'atuser@example.com'
        expect(page).to have_content 'Signed in successfully.'
        expect(page).to have_content I18n.t 'devise.sessions.signed_in'
        expect(page).to have_content 'Our Github Repo'
        expect(response).to render_template('profile')
        expect(assigns(:user)).to eq([User])

        # get :profile, id: user.id
        # NoMethodError:
        #   undefined method `authenticate!' for nil:NilClass

        # get :show, id: user.id
        #  ActionController::UrlGenerationError:
        #    No route matches {:action=>"show", :controller=>"users", :id=>nil}

       end

      it 'assigns a newly created user as @user' do
        # email = 'auser@example.com'
        # password = 'please123'
        # password_confirmation = 'please123'
        # user_registration POST /users(.:format)   devise_invitable/registrations#create
        @user = FactoryGirl.create(:user, email: 'newlycreated@example.come')
        get :show, @user.id.to_s
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted

        # post :user_registration_path, user: { id: 17, email: email, password: password, password_confirmation: password_confirmation } # template works ?
        # post :users, user_registration: { email: email, password: password, password_confirmation: password_confirmation } # template works ?
        # ActionController::UrlGenerationError: No route matches
        #  {:action=>"users", :controller=>"users", :user_registration=>{:email=>"auser@example.com", :password=>"please123", :password_confirmation=>"please123"}}

        # post :create, user_registration: { email: email, password: password, password_confirmation: password_confirmation } # template works ?
        # ActionController::UrlGenerationError: No route matches
        #  {:action=>"create", :controller=>"users", :user_registration=>{:email=>"auser@example.com", :password=>"please123", :password_confirmation=>"please123"}}

        # post :create, user_registration: { id: 5, email: @user.email, password: 'invalid' }
        # post :create, user_registration: { id: 5, email: @user.email, password: 'invalid' }
        # new_user_session GET      /users/login(.:format)                 devise/sessions#new
        # user_session POST     /users/login(.:format)                 devise/sessions#create
        # destroy_user_session DELETE   /users/logout(.:format)                devise/sessions#destroy


        # post :create, user: { id: 5, valid_user_attributes } @valid_session
        # post :create, user: { id: 5, @valid_user_attributes, @valid_session }
        # post :create, user: { id: 5, email: @user.email, password: 'invalid' }
        # post :post, @valid_user_attributes, @valid_session
        # ActionController::UrlGenerationError:
        #   No route matches {:action=>"post", :controller=>"users"}        
        #
        # post "/widgets", :widget => {:name => "My Widget"}
        # post :create, user: { email: @user.email, password: @user.password }
        # post :create, { user: @valid_user_attributes }, @valid_session
        # post :create, { user: @valid_user_attributes }, @valid_session        
        # # ActionController::UrlGenerationError: No route matches
        # {
        #   :action=>"create",
        #   :controller=>"users",
        #   :user=>{
        #     :name=>"Test User",
        #     :email=>"test@example.com",
        #     :password=>"please123",
        #     :confirmed_at=>"2016-04-07 14:29:02 UTC"
        #   }
        # }
        # # #
        # # #
        # post :create, user: attributes_for(:user)
        # post :create, user: attributes_for(:user)
        # # ActionController::UrlGenerationError: No route matches
        # {
        #   :action=>"create",
        #   :controller=>"users",
        #   :user=>{
        #     :name=>"Test User",
        #     :email=>"test@example.com",
        #     :password=>"please123",
        #     :confirmed_at=>"2016-04-07 14:29:02 UTC"
        #   }
        # }

        # post :create, session: { email: @user.email, password: 'invalid' }

        # post "/widgets", :widget => {:name => "My Widget"}
        # post :create, user: { email: @user.email, password: @user.password }

        # post :create, { user: @valid_user_attributes } #f

        # expect(assigns(:user)).to be_a(User)
        # expect(assigns(:user)).to be_persisted
      end
    end # with valid params

    context 'with invalid params' do
      it 'assigns a newly created but unsaved user as @user' do
        post :create, @valid_user_attributes, @valid_session
        # post :create, { user: @valid_user_attributes } #f

        expect(assigns(:user)).to be_a_new(User)
      end

      it 'returns unprocessable_entity status' do
        post :create, { user: @invalid_user_attributes }, @valid_session
        # post :create, { user: @invalid_user_attributes } # f

        expect(response.status).to eq(422)
      end
    end # with invalid params
  end # POST #create

  describe 'Visit users_profile' do
    it 'renders the /users/profile view for User' do # f
      # # # 
      # # Sign in / Log in Test Version 1
      # # https://github.com/plataformatec/devise/
      # # Four Devise test_helper methods available
      # # sign_in :user, @user # sign_in(scope, resource)
      # # sign_in @user # sign_in(resource)
      # # sign_out :user # sign_out(scope)
      # # sign_out @user # sign_out(resource)
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      # sign_in :user, @user
      # 
      # use above or below, but not both
      #
      # # Sign in / Log in Test Version 2
      # # signin method in support/helpers/sessions_helper.rb
      # # signin(email, password) # template

      # Failure/Error: raise ActionController::RoutingError, "No route matches [#{env['REQUEST_METHOD']}] #{env['PATH_INFO'].inspect}"
      #  ActionController::RoutingError:
      #  No route matches [GET] "/vendor/assets/javascripts/jquery.geocomplete.js"

      @request.env['devise.mapping'] = Devise.mappings[:user]
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      #  => #<Devise::Mapping:0x007fdcf01980f0
      #   @class_name="User",
      #   @controllers=
      #    {:omniauth_callbacks=>"users/omniauth_callbacks",
      #     :registrations=>"devise_invitable/registrations",
      #     :sessions=>"devise/sessions",
      #     :passwords=>"devise/passwords",
      #     :invitations=>"devise/invitations"},
      #   @failure_app=Devise::FailureApp,
      #   @format=nil,
      #   @klass=#<Devise::Getter:0x007fdcf0193a78 @name="User">,
      #   @modules=[:database_authenticatable, :rememberable, :omniauthable, :recoverable, :registerable, :validatable, :trackable, :invitable],
      #   @path="users",
      #   @path_names=
      #    {:registration=>"",
      #     :new=>"new",
      #     :edit=>"edit",
       #    :sign_in=>"login",
       #    :sign_out=>"logout",
       #    :password=>"password",
       #    :sign_up=>"sign_up",
      #     :cancel=>"cancel",
      #     :invitation=>"invitation",
      #     :accept=>"accept",
      #     :remove=>"remove"},
      #   @path_prefix=nil,
      #   @router_name=nil,
      #   @routes=[:session, :omniauth_callback, :password, :registration, :invitation],
      #   @scoped_path="users",
      #   @sign_out_via=:delete,
      #   @singular=:user,
      #   @strategies=[:rememberable, :database_authenticatable],
      #   @used_helpers=[:session, :omniauth_callback, :password, :registration, :invitation],
      #   @used_routes=[:session, :omniauth_callback, :password, :registration, :invitation]>
      #
      signin(@user.email, @user.password)
      #  => "ok"
      #
      # # #
      expect(current_path).to eq '/'

      # bonus testing while we are here
      visit '/products/new'
      expect(response.status).to eq 200
      expect(response).to be_success
      expect(current_path).to eq '/products/new'
    end

    it 'populates an array of users' do # f
        pending 'not picking up current_path'
        @user = FactoryGirl.build(:user, email: 'youare@example.com')
        @user.role = 'admin'
        @user.save!
        # users = User.all # unused
        expect(@users.class).to eq User::ActiveRecord_Relation

        @request.env['devise.mapping'] = Devise.mappings[:user]
        signin(@user.email, @user.password)
        expect(response.status).to eq 200
        expect(response).to be_success

        visit '/users/profile'
        expect(page).to have_content('Signed in successfully.')
        expect(page).to have_content('Profile youare@example.com')
    end

    # Assigns are tested only in functional tests (spec/controllers)
    # http://stackoverflow.com/questions/10039253/why-i-can-not-get-current-user-while-writing-test-case-with-rspec-and-capybara
    it 'assigns @user' do # f
        @user = FactoryGirl.build(:user, email: 'youare@example.com')
        @user.role = 'admin'
        @user.save!
        expect(User.all.size).to eq 2
        # # https://github.com/plataformatec/devise/
        # # Four Devise test_helper methods available
        # # sign_in :user, @user # sign_in(scope, resource)
        # # sign_in @user # sign_in(resource)
        # # sign_out :user # sign_out(scope)
        # # sign_out @user # sign_out(resource)
        sign_in :user, @user
        # 
        # use above or below, but not both
        #
        # @request.env['devise.mapping'] = Devise.mappings[:admin]
        # signin method in support/helpers/sessions_helper.rb
        # signin(email, password) # template
        # signin(@user.email, @user.password)

        expect(response.status).to eq 200
        expect(response).to be_success

        visit '/users/profile'
        expect(current_path).to eq '/users/profile'
        expect(page).to have_content 'Account Settings'
        expect(page).to have_content 'youare@example.com'
        expect(page).to have_content 'Signed in successfully.'
        expect(page).to have_content I18n.t 'devise.sessions.signed_in'
        expect(page).to have_content 'Our Github Repo'
        expect(response).to render_template('profile')
        expect(assigns(:user)).to eq([User])

        # visit '/admin/users'
        # expect(current_path).to eq '/users'
        # save_and_open_page
        # sign_in(user.email, user.password)
        # visit '/admin_users'

        expect(response.status).to eq 200
        expect(current_path).to eq '/users/login'
        # get :index, controller: 'admin', as: :index
        expect(assigns(:user)).to eq([User])
        expect(assigns(:users.class)).to eq User::ActiveRecord_Relation

        users = User.all
        expect(users.class).to eq User::ActiveRecord_Relation
        expect(users.size).to eq 2

        email = @user.email
        password = @user.password 
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        signin(email, password)
        expect(User.all.size).to eq 2
        expect(@user.id).to eq 2
        expect(@user.email).to eq 'youare@example.com'
        expect(@user.persisted?).to eq true

        users = User.all
        expect(users.size).to eq 2
        visit '/users'
        expect(response.status).to eq 200
        expect(current_path).to eq '/users'
        expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'is successful' do
      respond_to(@user)
    end

    it 'is successful' do # f
        pending 'not picking up current_path'
        @user = FactoryGirl.build(:user, email: 'youare@example.com')
        @user.role = 'admin'
        @user.save!
        @users = User.all

        expect(@users.class).to eq User::ActiveRecord_Relation
        expect(@user._validators?).to eq true
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        signin :user, @user   # sign_in(scope, resource)
     
        # Devise templates:
        # sign_in @user          # sign_in(resource)
        #
        # sign_out :user         # sign_out(scope)
        # sign_out @user         # sign_out(resource)        

        # ref: for this
        # login_as user
        #
        # ref: for this is in support/helpers/session_helpers.rb
        # signin(user.email, user.password)

        expect(current_path).to eq '/users'

        visit '/users/1'
        expect(Rails.logger.info(response.body)).to eq true
        expect(Rails.logger.warn(response.body)).to eq true
        expect(Rails.logger.debug(response.body)).to eq true
        expect(response).to be_success
    end

    it 'finds the right user' do # passing
        user = FactoryGirl.build(:user, email: 'newuser@example.com')
        user.role = 'admin'
        user.save!

        @request.env['devise.mapping'] = Devise.mappings[:admin]
        signin(user.email, user.password)
        visit '/users/profile'
        expect(response).to be_success
        expect(page).to have_content(user.email)
    end
  end # is successful
end # GET #show
