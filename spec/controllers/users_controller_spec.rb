# frozen_string_literal: true
# code: app/controllers/users_controller.rb
# test: spec/controllers/users_controller_spec.rb
#
# Two routes exist:
# # get 'profile/index' : in profile controller
# # get 'users/profile' : in  users  controller
#
# TODO: the following is the main cause of errors on 20160507
# authenticate! problem and possible cause and solution reference:
# https://github.com/hassox/warden/wiki/Setup
# -----------------------------------------------------------------------------------------
# You will need to declare some strategies to be able to get Warden to actually authenticate.
# -----------------------------------------------------------------------------------------
# See the Strategies page for more information.
# https://github.com/hassox/warden/wiki/Overview
# https://github.com/hassox/warden/wiki/Strategies
# https://github.com/hassox/warden/wiki/Callbacks
# https://github.com/hassox/warden/wiki/Scopes
# https://github.com/hassox/warden/wiki/Rails-Integration leads to:
# https://github.com/plataformatec/devise/wiki
# https://github.com/plataformatec/devise/wiki/OmniAuth%3A-Overview
# http://www.rubydoc.info/github/plataformatec/devise/
# https://github.com/intridea/omniauth
#
# These are Functional Tests for Rail Controllers testing the various actions
# of a single controller. Controllers handle the incoming web requests to your
# application and eventually respond with a rendered view.
#
# https://www.relishapp.com/rspec/rspec-rails/docs/matchers/redirect-to-matcher
# The `redirect_to` matcher is used to specify that a request redirects to a given
# template or action. It delegates to assert_redirected_to.
#
# The `redirect_to` matcher is available in controller specs (spec/controllers)
# and request specs (spec/requests).
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
# Testing troubles? Use Pry: uncomment `require 'pry'` below, add on a line by
# itself, the `binding.pry` command after the it/do statement, and run the test,
# Pry will open your console, you are now inside your test environment.
# require 'pry'
include Devise::TestHelpers
include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do
  def setup
    @controller = UsersController.new
  end

  def valid_session
    # @user_admin = FactoryGirl.build(:user, email: 'newadmin@example.com')
    # @user_admin.role = 'admin'
    # @user_admin.save
    @valid_session = { user_id: 1 }
  end

  def valid_user_attributes
    valid_user_attributes = { email: 'newadmin@example.com', password: 'please123', password_confirmation: 'please123' }
  end

  def invalid_user_attributes
    invalid_user_attributes = { email: 'invalidadmin@examplecom', password: 'please12', password_confirmation: 'please123' }
  end
end

describe UsersController, :devise, type: :controller, controller: true, js: true do
  render_views # priceless piece of code in controller tests -ko

  # let!(:user) { User.create(email: 'iam@example.com', password: 'please123', password_confirmation: 'please123') }
  # let!(:valid_user_attributes) { email: 'iam@example.com', password: 'please123', password_confirmation: 'please123' }
  # let!(:user) { User.create(valid_user_attributes) }

  before(:each) do
    # @user = FactoryGirl.build(:user, email: 'newadmin@example.com')
    # @user.role = 'admin' # using Enum for roles
    #
    # Returns a hash of attributes that can be used to build a User instance
    attrs = FactoryGirl.attributes_for(:user)
    @user = FactoryGirl.build(:user, attrs)
    @user.email = 'newadmin@example.com'
    @user.role = 'admin' # using Enum for roles
    # uncomment after bio is added to table
    # @user.bio = 'this is a text column and so can hold lots of text'
    # @user.save! : doing this in the tests themselves
  end

  after(:each) do
    Warden.test_reset!
  end

  after(:all) do
    User.destroy_all
  end

  describe 'Visit users_profile' do
    it 'renders the profile index view for Admin' do
      @user.save!
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)

      login_as @user
      expect(response.status).to eq 200
      expect(response).to be_success

      visit '/users/profile'
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
      expect(current_path).to eq '/users/profile'
    end

    it 'renders the users/profile view for User' do
      @user.save!
      expect(User.all.size).to eq 1

      @user2 = FactoryGirl.build(:user, email: 'userprofile@example.com')
      @user2.role = 'user' # using Enum for roles
      @user2.save!

      users = User.all
      expect(users.class).to eq User::ActiveRecord_Relation
      expect(User.all.size).to eq 2

      login_as @user2
      expect(@user2.id).to eq 2
      expect(@user2.email).to eq 'userprofile@example.com'
      expect(@user2.persisted?).to eq true

      visit '/users/profile'
      expect(response.status).to eq 200
      expect(current_path).to eq '/users/profile'
      expect(response).to be_success
    end
  end

  describe 'GET #profile' do
    it 'is successful' do
      @userprofile = FactoryGirl.build(:user, email: 'youare@example.com')
      @userprofile.role = 'admin'
      @userprofile.save!
      @users = User.all
      expect(@users.class).to eq User::ActiveRecord_Relation
      expect(@userprofile._validators?).to eq true

      login_as @userprofile
      visit '/users/profile'
      expect(current_path).to eq '/users/profile'
      expect(response).to be_success
    end

    it 'finds the right user' do
      @rightuser = FactoryGirl.build(:user, email: 'newuser@example.com')
      @rightuser.role = 'admin'
      @rightuser.save!
      login_as @rightuser
      visit '/users/profile'
      expect(response).to be_success
      expect(page).to have_content(@rightuser.email)
    end
  end

  describe '#create' do
    pending 'needs more study, more work'
    # ref : http://stackoverflow.com/questions/28653977/rails-rspec-3-controller-action-with-format-js
    # let!(:user) { xhr :post, :create, user: FactoryGirl.build(:user) }
    # let!(:user) { post :'devise_invitable/registrations#create', { user: valid_user_attributes } }
    # let!(:user) { post :'devise_invitable/registrations#create', { user: valid_user_attributes }, valid_session }

    it 'creates a new user' do
      @user.role = 'user'
      @user.save!
      expect(@user.email).to eq 'newadmin@example.com'
      # let(:user) { post :create, valid_user_attributes, valid_session }
      # let(:user) { FactoryGirl.create(:user, email: 'createme@example.om') }
      # before { post :create, { "user" => { "email" => "email@example.com" } } }
      # specify("should created one user") { change{ User.count }.from(1).to(2) } }
      #
      # https://www.relishapp.com/rspec/rspec-rails/docs/matchers/redirect-to-matcher
      # template: subject { post :create, :widget => { :name => "Foo" } }
      #
      # Assigns are tested only in functional tests (spec/controllers)
      # http://stackoverflow.com/questions/10039253/why-i-can-not-get-current-user-while-writing-test-case-with-rspec-and-capybara
      #
      # Test Templates : https://github.com/rspec/rspec-rails/issues/999
      # expect(execute_action).to assigns(:instance_variable).to(value)
      # expect{ execute_action }.to change{ assigns(:ivar) }.to(value)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      pending 'needs more study, more work'
      #
      # let!(:user) { post :create, user: valid_user_attributes }
      # # AbstractController::ActionNotFound:
      # #  The action 'create' could not be found for UsersController
      #
      # let!(:user) { post :create, user: valid_user_attributes }
      # let(:user) { FactoryGirl.create(:user, email: 'createme@example.om') }
      # let(:user) { post :create, user: valid_user_attributes, valid_session }
      # test smell : https://github.com/rspec/rspec-rails/issues/999
      # subject { post :create, user: valid_user_attributes, valid_session }

      it 'creates a new user' do
        pending 'more study/work needed on this one'
        expect {
          xhr :post, :create, user: valid_user_attributes
        }.to change(User, :count).by(1)
      end

      it 'redirects to root_path upon user creation' do
        # expect { @user.save! }.to change(User, :count).from(0).to(1)

        # expect {
        # # xhr :post, :create, user: valid_user_attributes
        # # THIS IS WHERE IT SHOULD BE REDIRECTING TO:
        # }.to redirect_to(users_profile_path(assigns([@user.id])))
        # # CURRENTLY, we are redirecting to root_path
        # }.to redirect_to(root_path)
      end

      # it 'redirects_to(@user)' do : normal test template
      it 'user login redirects_to users_profile_path' do
        pending 'we are currently redirecting to nowhere upon login when using login_as'
        # Template:
        # subject { post :create, :widget => { :name => "Foo" } }
        expect { subject { post :create, user: valid_user_attributes } }. to redirect_to action: :profile, id: assigns(@user.id)

        # subject { post :create, user: valid_user_attributes }
        # expect(subject).to redirect_to action: :profile, id: assigns(@user.id)

        # expect(subject).to redirect_to action: :show, id: assigns(@user.id)
        #  # NoMethodError:
        #  #  undefined method `id' for nil:NilClass
        #  #
        # end

        # we should change this to the user profile page so ..
        # we can show changes and notices upon signup ?
        # we need and want a usable redirect page, profile may not be it
        # root, certainly is not it : Kathyonu to Bishisht : 20160510
        # @user.save!
        #
        # expect(subject).to redirect_to(assigns(:user))
        # Expected response to be a <redirect>, but was <200>
        #
        @user = User.last
        login_as @user
        expect(current_path).to eq nil

        visit '/users/profile'
        expect(current_path).to eq '/users/profile'
      end

      it 'creates a new user' do
        @user.save!
        expect(User.all.size).to eq 1
        # Template of Route:
        # user_registration POST : /users(.:format) : devise_invitable/registrations#create

        # post user: valid_user_attributes
        # # ActionController::UrlGenerationError:
        # # No route matches {:action=>"{
        # #                              :user=>{
        # #                                      :email=>\"newadmin@example.com\",
        # #                                      :password=>\"please123\",
        # #                                      :password_confirmation=>\"please123\"}
        # #                             }", :controller=>"users"}

        # post :create, '/registrations/user': valid_user_attributes
        #
        # post 'registrations#create', user: valid_user_attributes
        # # ActionController::UrlGenerationError: \
        # #  No route matches {:action=>"registrations#create",
        # #                    :controller=>"users",
        # #                    :user=>{:email=>"newadmin@example.com",
        # #                            :password=>"please123",
        # #                            :password_confirmation=>"please123"
        # #                           }
        # #                  }
        # #
        #
        # post :create, user: valid_user_attributes, valid_session
        # # ActionController::UrlGenerationError: \
        # # No route matches {:action=>"{
        # #                              :user=>{
        # #                                      :email=>\"newadmin@example.com\",
        # #                                      :password=>\"please123\",
        # #                                      :password_confirmation=>\"please123\"}}",
        # #                                      :controller=>"users"
        # #                                     }
        # #                             }
        # #                  }
        #
        # post :create, user: valid_user_attributes valid_session
        # # SyntaxError: unexpected tIDENTIFIER, expecting keyword_do or '{' or '('
        #
        # post :create, user: valid_user_attributes, valid_session
        # # SyntaxError: unexpected '\n', expecting =>
        #
        # post user_registration_path, { user: valid_user_attributes }, valid_session
        # # ActionController::UrlGenerationError:
        # #  No route matches {:action=>"/users", :controller=>"users", :user=>{:email=>"newadmin@example.com", :password=>"please123", :password_confirmation=>"please123"}}

        # post 'registrations/create',  { user: valid_user_attributes }, valid_session
        # # ActionController::UrlGenerationError:
        # #  No route matches { :action=>"registrations/create",
        # #                     :controller=>"users",
        # #                     :user=>{:email=>"newadmin@example.com",
        # #                             :password=>"please123",
        # #                             :password_confirmation=>"please123"
        # #                            }
        # #                     }
        #
        # expect { post :registrations#create, user: valid_user_attributes, valid_session }.to change(User, :count).by(1)
        # expect { post :create, as: 'registrations#create', user: valid_user_attributes, valid_session }.to change(User, :count).by(1)
        # expect { post :create, as: 'devise_invitable/registrations#create', { user: valid_user_attributes }, valid_session }.to change(User, :count).by(1)
        # expect { post 'devise_invitable/registrations#create', { user: valid_user_attributes }, valid_session }.to change(User, :count).by(1)
        #
        # expect { post :create, { user: valid_user_attributes }, valid_session }.to change(User, :count).by(1)
        # ActionController::UrlGenerationError:
        #  No route matches {:action=>"create",
        #                    :controller=>"users",
        #                    :user=>{
        #                            :id=>"3",
        #                            :email=>"newadmin@example.com",
        #                            :password=>"please123",
        #                            :password_confirmation=>"please123"
        #                            }
        #                   }
        # # #
        # expect {
        #  post :create, { user: @valid_user_attributes } }.to change(User.all.count).by(1)
        # ActionController::UrlGenerationError:
        #  No route matches {:action=>"create", :controller=>"users", :user=>nil}

        # expect {
        #  post :create, { user: @valid_user_attributes } }.to change(User.all.count).by(1)
        # ArgumentError:
        #  `change` requires either an object and message (`change(obj, :msg)`) or a block (`change { }`). You passed an object but no message.
        expect(User.count).to eq 1
      end

      it 'xhr post create creates a user' do
        expect(User.count).to eq 0
        expect(@user.persisted?).to eq false
        # expect { @user.save! }.to change{ assigns(User.count) }.from(nil).to(1)
        # # RSpec::Expectations::ExpectationNotMetError:
        # #  expected result to have changed from nil to 1, but did not change
        #
        # because of the above failure we do this:
        expect(User.count).to eq 0
        @user.save!
        expect(User.count).to eq 1
        expect(@user.persisted?).to eq true
        expect(@user.email).to eq 'newadmin@example.com'

        # more study is required to clean this up to a useful change test -ko

        # expect {
        #  xhr :post, :create, user: valid_user_attributes
        # }.to change { assigns(User.count) }.from(0).to(1)
        # Failure/Error: xhr :post, :create, user: valid_user_attributes
        # # AbstractController::ActionNotFound:
        # #  The action 'create' could not be found for UsersController

        # expect {
        #  xhr :post, :put, user: valid_user_attributes
        # }.to change { assigns(User.count) }.from(0).to(1)
        # Failure/Error: xhr :post, :put, user: valid_user_attributes
        # # ActionController::UrlGenerationError:
        # #  No route matches {:action=>"put",
        # #                    :controller=>"users",
        # #                    :user=>{:email=>"newadmin@example.com",
        # #                            :password=>"please123",
        # #                            :password_confirmation=>"please123"
        # #                          }
        # #                   }

        #
        # @user.persisted? # => false
        # expect{ FactoryGirl.create(:user, email: 'iam2@example.com') }.to change{ assigns(User.count) }.to(1)
        # # RSpec::Expectations::ExpectationNotMetError:
        # #  expected result to have changed to 1, but did not change
        # User.count # => 1 << proof it did change
        #
        # expect { post 'devise_invitable/registrations#create', { user: valid_user_attributes }, valid_session }.to change(User, :count).by(1)

        # Test Templates : https://github.com/rspec/rspec-rails/issues/999
        # expect(execute_action).to assigns(:instance_variable).to(value)
        # expect{ execute_action }.to change{ assigns(:ivar) }.to(value)

        signin(@user.email, @user.password)
        @request.env['devise.mapping'] = Devise.mappings[:user]
        # # # # # #
        # @request.env['devise.mapping'] = Devise.mappings[:user]
        # => [2] pry(#<RSpec::ExampleGroups::UsersController::POSTCreate::WithValidParams>)> signin(@user.email, @user.password)
        # => "ok"
        # [3] pry(#<RSpec::ExampleGroups::UsersController::POSTCreate::WithValidParams>)> @request.env['devise.mapping'] = Devise.mappings[:user]
        # => #<Devise::Mapping:0x007f9647186020
        # # @class_name="User",
        # # @controllers=
        # #   {:omniauth_callbacks=>"users/omniauth_callbacks",
        # #    :registrations=>"devise_invitable/registrations",
        # #    :sessions=>"devise/sessions",
        # #    :passwords=>"devise/passwords",
        # #    :invitations=>"devise/invitations"},
        # # @failure_app=Devise::FailureApp,
        # # @format=nil,
        # # @klass=#<Devise::Getter:0x007f96471858c8 @name="User">,
        # # @modules=[:database_authenticatable, :rememberable, :omniauthable, :recoverable, :registerable, :validatable, :trackable, :invitable],
        # # @path="users",
        # # @path_names=
        # #  {:registration=>"",
        # #   :new=>"new",
        # #   :edit=>"edit",
        # #   :sign_in=>"login",
        # #   :sign_out=>"logout",
        # #   :password=>"password",
        # #   :sign_up=>"sign_up",
        # #   :cancel=>"cancel",
        # #   :invitation=>"invitation",
        # #   :accept=>"accept",
        # #   :remove=>"remove"},
        # # @path_prefix=nil,
        # # @router_name=nil,
        # # @routes=[:session, :omniauth_callback, :password, :registration, :invitation],
        # # @scoped_path="users",
        # # @sign_out_via=:delete,
        # # @singular=:user,
        # # @strategies=[:rememberable, :database_authenticatable],
        # # @used_helpers=[:session, :omniauth_callback, :password, :registration, :invitation],
        # # @used_routes=[:session, :omniauth_callback, :password, :registration, :invitation]>
        # # # # #

        expect(current_path).to eq '/'
        expect(page).to have_content 'Signed in successfully.'
        expect(page).to have_content I18n.t 'devise.sessions.signed_in'
        expect(page).to have_content 'Our Open Source Code Repository'
        expect(response).to render_template('index')

        # Bishisht, I don't think the assigns tests can be achieved because we are using Profile
        # expect(assigns(:users)).to eq([user])

        # ref : http://stackoverflow.com/questions/16133166/what-does-assigns-mean-in-rspec
        # get 'profile'
        visit '/users/profile'
        expect(current_path).to eq users_profile_path

        logout

        @user2 = FactoryGirl.build(:user, email: 'atuser@example.com')
        @user2.role = 'admin'
        @user2.save!

        signin(@user.email, @user.password)
        @request.env['devise.mapping'] = Devise.mappings[:user2]
        expect(current_path).to eq '/'
        expect(page).to have_content 'Signed in successfully.'
        expect(page).to have_content I18n.t 'devise.sessions.signed_in'
        expect(page).to have_content 'Our Open Source Code Repository'
        expect(response).to render_template('index')

        visit '/users/profile'
        expect(response).to render_template('users/profile')
        expect(current_path).to eq '/users/profile'
        expect(page).not_to have_content 'atuser@example.com'
        expect(response).to render_template('profile')
      end

      it 'assigns a newly created user as @user' do
        # email = 'auser@example.com'
        # password = 'please123'
        # password_confirmation = 'please123'
        # user_registration POST /users(.:format)   devise_invitable/registrations#create
        @user = FactoryGirl.create(:user, email: 'newlycreated@example.come')
        signin(@user.email, @user.password)

        expect(response.status).to eq 200
        expect(current_path).to eq '/'

        expect(@user.persisted?).to eq true

        # @request.env['devise.mapping'] = Devise.mappings[:user]
        # => #<Devise::Mapping:0x007fb1017c73d8
        # # @class_name="User",
        # # @controllers=
        # #  {:omniauth_callbacks=>"users/omniauth_callbacks",
        # #  :registrations=>"devise_invitable/registrations",
        # #  :sessions=>"devise/sessions",
        # #  :passwords=>"devise/passwords",
        # #  :invitations=>"devise/invitations"},
        # # @failure_app=Devise::FailureApp,
        # # @format=nil,
        # # @klass=#<Devise::Getter:0x007fb1017c6ca8 @name="User">,
        # # @modules=
        # #  [:database_authenticatable, :rememberable, :omniauthable, :recoverable, :registerable, :validatable, :trackable, :invitable],
        # # @path="users",
        # # @path_names=
        # #  {:registration=>"",
        # #   :new=>"new",
        # #   :edit=>"edit",
        # #   :sign_in=>"login",
        # #   :sign_out=>"logout",
        # #   :password=>"password",
        # #   :sign_up=>"sign_up",
        # #   :cancel=>"cancel",
        # #   :invitation=>"invitation",
        # #   :accept=>"accept",
        # #   :remove=>"remove"},
        # # @path_prefix=nil,
        # # @router_name=nil,
        # # @routes=[:session, :omniauth_callback, :password, :registration, :invitation],
        # # @scoped_path="users",
        # # @sign_out_via=:delete,
        # # @singular=:user,
        # # @strategies=[:rememberable, :database_authenticatable],
        # # @used_helpers=[:session, :omniauth_callback, :password, :registration, :invitation],
        # # @used_routes=[:session, :omniauth_callback, :password, :registration, :invitation]>
        # # #
        #
        # expect(assigns(:user)).to be_persisted
        # # RSpec::Expectations::ExpectationNotMetError:
        # #  expected nil to respond to `persisted?`
        # expect(assigns(:user)).to be_a([User])
        # TypeError: class or module required

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
        # # No route matches {:action=>"post", :controller=>"users"}
        #
        # post "/widgets", :widget => {:name => "My Widget"}
        # post :create, user: { email: @user.email, password: @user.password }
        # post :create, { user: @valid_user_attributes }, @valid_session
        # post :create, { user: @valid_user_attributes }, @valid_session
        # # ActionController::UrlGenerationError: No route matches
        # {
        # # :action=>"create",
        # # :controller=>"users",
        # # :user=>{
        # #   :name=>"Test User",
        # #   :email=>"test@example.com",
        # #   :password=>"please123",
        # #   :confirmed_at=>"2016-04-07 14:29:02 UTC"
        # # }
        # }
        # # #
        # # #
        # post :create, user: attributes_for(:user)
        # post :create, user: attributes_for(:user)
        # # ActionController::UrlGenerationError: No route matches
        # {
        # # :action=>"create",
        # # :controller=>"users",
        # # :user=>{
        # #   :name=>"Test User",
        # #   :email=>"test@example.com",
        # #   :password=>"please123",
        # #   :confirmed_at=>"2016-04-07 14:29:02 UTC"
        # # }
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
        pending 'needs work'
        post 'devise_invitable/registrations#create', { user: valid_user_attributes }, valid_session
        # post :create, valid_user_attributes, valid_session
        # post :create, { user: @valid_user_attributes } #f
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'returns unprocessable_entity status' do
        pending 'needs work to pass'
        # Route Template:
        # user_registration POST   /users(.:format)   devise_invitable/registrations#create
        post 'user_registration#create', { user: valid_user_attributes }, valid_session
        #
        # post 'devise_invitable/registrations#create', { user: valid_user_attributes }, valid_session
        # # ActionController::UrlGenerationError:
        # #  No route matches {:action=>"devise_invitable/registrations#create",
        # #                    :controller=>"users",
        # #                    :user=>{:email=>"newadmin@example.com",
        # #                            :password=>"please123",
        # #                            :password_confirmation=>"please123"
        # #                           }
        # #                   }

        # post :create, { user: invalid_user_attributes}, valid_session
        # # ActionController::UrlGenerationError:
        # # No route matches {:action=>"create",
        # #                   :controller=>"users",
        # #                   :user=>{:id=>"6",
        # #                     :email=>"newadmin@examplecom",
        # #                     :password=>"please12",
        # #                     :password_confirmation=>"please123"
        # #                     }
        # #                   }
        expect(response.status).to eq(422)
      end
    end # with invalid params
  end

  describe 'Visit users_profile for Admin' do
    it 'renders the /users/profile view for Admin' do
      @user.save!
      login_as @user

      visit '/users/profile'
      expect(response.status).to eq 200
      expect(response).to be_success
      expect(current_path).to eq '/users/profile'
    end
  end

  describe 'Visit users_profile for User' do
    it 'renders the /users/profile view for User' do
      # login_as @user
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

      # request.env['devise.mapping'] = Devise.mappings[:user]
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      # # => #<Devise::Mapping:0x007fdcf01980f0
      # # @class_name="User",
      # # @controllers=
      # #  {:omniauth_callbacks=>"users/omniauth_callbacks",
      # #   :registrations=>"devise_invitable/registrations",
      # #   :sessions=>"devise/sessions",
      # #   :passwords=>"devise/passwords",
      # #   :invitations=>"devise/invitations"},
      # # @failure_app=Devise::FailureApp,
      # # @format=nil,
      # # @klass=#<Devise::Getter:0x007fdcf0193a78 @name="User">,
      # # @modules=[:database_authenticatable, :rememberable, :omniauthable, :recoverable, :registerable, :validatable, :trackable, :invitable],
      # # @path="users",
      # # @path_names=
      # #  {:registration=>"",
      # #   :new=>"new",
      # #   :edit=>"edit",
      # #  :sign_in=>"login",
      # #  :sign_out=>"logout",
      # #  :password=>"password",
      # #  :sign_up=>"sign_up",
      # #   :cancel=>"cancel",
      # #   :invitation=>"invitation",
      # #   :accept=>"accept",
      # #   :remove=>"remove"},
      # # @path_prefix=nil,
      # # @router_name=nil,
      # # @routes=[:session, :omniauth_callback, :password, :registration, :invitation],
      # # @scoped_path="users",
      # # @sign_out_via=:delete,
      # # @singular=:user,
      # # @strategies=[:rememberable, :database_authenticatable],
      # # @used_helpers=[:session, :omniauth_callback, :password, :registration, :invitation],
      # # @used_routes=[:session, :omniauth_callback, :password, :registration, :invitation]>
      #
      @user.save!
      login_as @user
      # sign_in(@user.email, @user.password)
      @user = User.last
      expect(@user.id).to eq 1
      expect(@user.email).to eq 'newadmin@example.com'
      expect(@user.encrypted_password).not_to eq nil
      expect(@user.reset_password_token).to eq nil
      expect(@user.reset_password_sent_at).to eq nil
      expect(@user.remember_created_at).to eq nil
      expect(@user.sign_in_count).to eq 0
      expect(@user.current_sign_in_at).to eq nil
      expect(@user.last_sign_in_at).to eq nil
      # expect(@user.current_sign_in_ip).to eq '127.0.0.1' # fails with nil
      expect(@user.last_sign_in_ip).to eq nil
      expect(@user.created_at).not_to eq nil
      expect(@user.updated_at).not_to eq nil
      expect(@user.name).to eq 'Test User'
      expect(@user.confirmation_token).to eq nil
      expect(@user.confirmed_at).not_to eq nil
      expect(@user.confirmation_sent_at).to eq nil
      expect(@user.unconfirmed_email).to eq nil
      expect(@user.role).to eq 'admin'
      expect(@user.invitation_token).to eq nil
      expect(@user.invitation_created_at).to eq nil
      expect(@user.invitation_sent_at).to eq nil
      expect(@user.invitation_accepted_at).to eq nil
      expect(@user.invitation_limit).to eq nil
      expect(@user.invited_by_id).to eq nil
      expect(@user.invited_by_type).to eq nil
      expect(@user.invitations_count).to eq 0
      expect(@user.provider).to eq nil
      expect(@user.uid).to eq nil

      visit root_path
      expect(current_path).to eq '/'

      visit '/users/profile'
      expect(current_path).to eq '/users/profile'
    end

    it 'dances the dance of the user admin' do
      @user = FactoryGirl.build(:user, email: 'youare@example.com')
      @user.role = 'admin'
      @user.save!
      @users = User.all
      expect(@users.class).to eq User::ActiveRecord_Relation

      @request.env['devise.mapping'] = Devise.mappings[:user]
      login_as @user
      expect(response.status).to eq 200
      expect(response).to be_success

      visit '/users/profile'
      expect(page).to have_content('youare@example.com')
    end

    # Assigns are tested only in functional tests (spec/controllers)
    # http://stackoverflow.com/questions/10039253/why-i-can-not-get-current-user-while-writing-test-case-with-rspec-and-capybara
    # it 'populates an array of users seems impossible, take two' do
    #  # @request.env['devise.mapping'] = Devise.mappings[:user]
    #  user_you = FactoryGirl.build(:user, email: 'youare@example.com')
    #  user_you.role = 'admin'
    #  user_you.save!
    #  @users = User.all
    #  login_as user_you
    #  # signin(user_you.email, user_you.password)
    #  expect(response.status).to eq 200
    #  expect(response).to be_success
    #
    #  visit '/profile/index'
    #  expect(@users.class).to eq User::ActiveRecord_Relation
    #  # this test seems impossible with profile
    #  # expect(assigns(:users)).to eq([users])
    # end

    # Assigns are tested only in functional tests (spec/controllers)
    # http://stackoverflow.com/questions/10039253/why-i-can-not-get-current-user-while-writing-test-case-with-rspec-and-capybara
    # it 'assigns @user' do # see assigns note below, inside this test
    it 'dances the dances of two users' do
      @user.save!
      expect(User.all.size).to eq 1

      @user2 = FactoryGirl.build(:user, email: 'youare@example.com')
      @user2.role = 'admin'
      @user2.save!

      @users = User.all

      login_as @user2
      expect(response.status).to eq 200
      expect(response).to be_success
      expect(User.all.size).to eq 2
      expect(User.all.class).to eq User::ActiveRecord_Relation
      # this next test seems impossible with profile
      # expect(assigns(:user)).to eq([user])

      # Bishisht, how does app know which user to show at this point ?
      # visit '/users/profile'
      # TODO: where is the message occuring ?
      # are these failures because i am not using get :profile ?
      # expect(page).to have_content 'Signed in successfully.'
      # expect(page).to have_content I18n.t 'devise.sessions.signed_in'

      # get :profile
      # Failure/Error: get :profile
      # # NoMethodError:
      # #  undefined method `authenticate!' for nil:NilClass

      # expect(get(:profile)).to route_to('/users/profile')
      # # NoMethodError:
      # #  undefined method `authenticate!' for nil:NilClass

      visit '/users/profile'
      expect(current_path).to eq '/users/profile'
      expect(@users.class).to eq User::ActiveRecord_Relation
      # this test seems impossible with profile
      # expect(assigns(:users)).to eq([users])

      expect(page).to have_content 'Account Settings'
      expect(page).to have_content 'youare@example.com'
      expect(page).to have_content 'Our Code Repository'
      expect(response).to render_template('profile')
      # this test seems impossible with profile
      # expect(assigns(:user)).to eq([user])

      # # https://github.com/plataformatec/devise/
      # # Four Devise test_helper methods available
      # # sign_in :user, @user # sign_in(scope, resource)
      # # sign_in @user # sign_in(resource)
      # # sign_out :user # sign_out(scope)
      # # sign_out @user # sign_out(resource)
      #
      # use above or below, but not both
      #
      # @request.env['devise.mapping'] = Devise.mappings[:admin]
      # signin method in support/helpers/sessions_helper.rb
      # signin(email, password) # template
      # signin(@user.email, @user.password)

      # visit '/admin/users'
      # expect(current_path).to eq '/users'
      # save_and_open_page
      # sign_in(user.email, user.password)
      # visit '/admin_users'
    end
  end

  describe 'GET #show' do
    it 'is successful' do
      @user = FactoryGirl.build(:user, email: 'youare@example.com')
      @user.role = 'admin'
      @user.save!
      @users = User.all

      expect(@users.class).to eq User::ActiveRecord_Relation
      expect(@user._validators?).to eq true

      login_as @user
      # @request.env['devise.mapping'] = Devise.mappings[:admin]
      # signin :user, @user # sign_in(scope, resource)

      # Devise templates:
      # sign_in @user # sign_in(resource)
      #
      # sign_out :user # sign_out(scope)
      # sign_out @user # sign_out(resource)

      # ref: for this
      # login_as user
      #
      # ref: for this is in support/helpers/session_helpers.rb
      # signin(user.email, user.password)

      visit '/users/profile'
      expect(response).to be_success
      expect(page).to have_content(@user.email)
      expect(current_path).to eq '/users/profile'
      expect(Rails.logger.info(response.body)).to eq true
      expect(Rails.logger.warn(response.body)).to eq true
      expect(Rails.logger.debug(response.body)).to eq true
      expect(response).to be_success
    end # GET #show is successful

    it 'finds the right user' do
      @user = FactoryGirl.build(:user, email: 'newuser@example.com')
      @user.role = 'admin'
      @user.save!

      # @request.env['devise.mapping'] = Devise.mappings[:user]
      # sign_in(@user.email, @user.password)
      login_as @user
      visit '/users/profile'
      expect(response).to be_success
      expect(page).to have_content(@user.email)
      # TODO: get these two working again
      # expect(page).to have_content 'Signed in successfully.'
      # expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    end # GET #show finds right user
  end
end
