# frozen_string_literal: true
# spec/controllers/users_controller_spec.rb
# tetsting app/controllers/users/users_controller.rb
# run command $ rspec spec/controllers/users/users_controller_spec.rb
# run command $ git diff spec/controllers/users/users_controller_spec.rb
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
# Testing troubles? Use Pry: uncomment `require 'pry'` below, add on a line by
# itself, the `binding.pry` command after the it/do statement, and run the test,
# Pry will open your console, you are now inside your test environment.
require 'pry'
#
# Test Templates : https://github.com/rspec/rspec-rails/issues/999
# expect(execute_action).to assigns(:instance_variable).to(value)
# expect{ execute_action }.to change{ assigns(:ivar) }.to(value)
RSpec.configure do
# include Devise::TestHelpers
  include Features::SessionHelpers
  include Warden::Test::Helpers

  def valid_session
    @user = FactoryGirl.build(:user, email: 'newadmin@example.com')
    @user.role = 'admin'
    @user.save
    @valid_session = { user_id: 1 }
  end

  def valid_user_attributes
    valid_user_attributes = { id: 3, email: 'newadmin@example.com', password: 'please123', password_confirmation: 'please123' }
  end

  def invalid_user_attributes
    invalid_user_attributes = { id: 6, email: 'newadmin@examplecom', password: 'please12', password_confirmation: 'please123' }
  end

  Warden.test_mode!
end

RSpec.describe UsersController, :devise, type: :controller, controller: true, js: true do
  # let!(:user) { User.create(email: 'iam@example.com', password: 'please123', password_confirmation: 'please123') }
  # let!(:valid_user_attributes) { email: 'iam@example.com', password: 'please123', password_confirmation: 'please123' }
  # let!(:user) { User.create(valid_user_attributes) }

  before(:each) do
    # Returns a hash of attributes that can be used to build a User instance
    attrs = FactoryGirl.attributes_for(:user)
    @user = FactoryGirl.build(:user, attrs)
    # @user = FactoryGirl.build(:user, email: 'test@example.com')
    @user.email = 'test@example.com'
    @user.role = 'admin' # using Enum for roles
    @user.save!
    @users = User.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe '#create' do
    let(:user) { post :create, valid_user_attributes, valid_session }
    # let(:user) { FactoryGirl.create(:user, email: 'createme@example.om') }
    # before { post :create, { "user" => { "email" => "email@example.com" } } }
    # specify("should created one user") { change{ User.count }.from(1).to(2) } }
    #
    # https://www.relishapp.com/rspec/rspec-rails/docs/matchers/redirect-to-matcher
    # template: subject { post :create, :widget => { :name => "Foo" } }
    # example : # expect(execute_action).to assigns(:instance_variable).to(value)
    # example : # expect{ execute_action }.to change{ assigns(:ivar) }.to(value)
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:user) { post :create, valid_user_attributes, valid_session }
      # let(:user) { FactoryGirl.create(:user, email: 'createme@example.om') }
      # let(:user) { post :create, user: valid_user_attributes, valid_session }
      # test smell : https://github.com/rspec/rspec-rails/issues/999
      # subject { post :create, user: valid_user_attributes, valid_session }

      it 'redirects to user_url(@user)' do
        # subject
        expect(@user).to change(User, :count).from(1).to(2)
        #
        # expect(:user).to change(User.count).from(1).to(2)
        # ArgumentError: `change` requires either an object and message (`change(obj, :msg)`)
        #  or a block (`change { }`). You passed an object but no message.
        #
        expect(:user).to redirect_to(user_url(assigns([User])))
       end

      it 'redirects_to action: :show' do
        expect(@user).to redirect_to action: :show, id: assigns(:user).id
        #
        # expect(subject).to redirect_to action: :show, id: assigns(:user).id
        # NoMethodError:
        #  undefined method `id' for nil:NilClass
        #
     end

      it 'redirects_to(@user)' do
        expect(@user).to redirect_to(assigns(:user))
        #
        # expect(subject).to redirect_to(assigns(:user))
        # Expected response to be a <redirect>, but was <200>
        #
      end

      it 'redirects_to /user/:id' do
        expect(@user).to redirect_to("/users/#{assigns(:user).id}")
        #
        # expect(subject).to redirect_to("/users/#{assigns(:user).id}")
        # NoMethodError:
        #  undefined method `id' for nil:NilClass
        #
      end

      it 'creates a new user' do # f
        expect(User.all.size).to eq 1
        expect { post :create, { user: valid_user_attributes }, valid_session }.to change(User, :count).by(1)
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
        expect(User.all.size).to eq 2
      end

      it 'assigns a requested user as @user' do
        # subject
        @user = User.last
        # Test Templates : https://github.com/rspec/rspec-rails/issues/999
        # expect(execute_action).to assigns(:instance_variable).to(value)
        # expect{ execute_action }.to change{ assigns(:ivar) }.to(value)
        expect(assigns(:users)).to eq([User])
        #
        # expect(assigns(:users)).to eq([User])
        # expected: [User(id: integer, email: string, ...
        #  got: nil
        #

        @user = FactoryGirl.build(:user, email: 'atuser@example.com')
        @user.role = 'admin'
        @user.save!

        @request.env["devise.mapping"] = Devise.mappings[:user]
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
        expect(assigns(:user)).to eq([@user])
        # expect(assigns(:user)).to eq([User])

        # get :profile, id: user.id
        # NoMethodError:
        # undefined method `authenticate!' for nil:NilClass

        # get :show, id: user.id
        # ActionController::UrlGenerationError:
        # No route matches {:action=>"show", :controller=>"users", :id=>nil}
      end

      it 'assigns a newly created user as @user' do
        # email = 'auser@example.com'
        # password = 'please123'
        # password_confirmation = 'please123'
        # user_registration POST /users(.:format)   devise_invitable/registrations#create
        @user = FactoryGirl.create(:user, email: 'newlycreated@example.come')
        @request.env["devise.mapping"] = Devise.mappings[:user]
        signin(@user.email, @user.password)

        visit '/users/profile'
        expect(response.status).to eq 200
        expect(current_path).to eq '/users/profile'
        # get :show, @user.id.to_s
        # get :show, @user.id.to_s
        # ActionController::UrlGenerationError:
        # No route matches {:action=>"show", :controller=>"users"}
        # get :show, @user
        # NoMethodError: undefined method `key?' for #<User:0x007fd9b1138a48>
        # from /Users/William/.rvm/gems/ruby-2.3.0@Rails4.2_visitmeet/gems/activemodel-4.2.5.1/lib/active_model/attribute_methods.rb:433:in `method_missing'
        # [2] pry(#<RSpec::ExampleGroups::UsersController_2::POSTCreate::WithValidParams>)

        # > visit "/show##{@user.id}"
        # => ""
        # browser shows : http://127.0.0.1:63766/show#2 : which is not correct
        # Internal Server Error : No route matches [GET] "/show"
        # WEBrick/1.3.1 (Ruby/2.3.0/2015-12-25) at 127.0.0.1:63766 


        # visit "/show##{@user.id}"
        expect(assigns(:user)).to be_persisted
        # expect(assigns(:user)).to be_persisted
        # # RSpec::Expectations::ExpectationNotMetError:
        # #  expected nil to respond to `persisted?`
        expect(assigns(:user)).to be_a([User])
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
        post :create, valid_user_attributes, valid_session
        # post :create, { user: @valid_user_attributes } #f
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'returns unprocessable_entity status' do
        pending 'needs work to pass'
        post :create, { user: invalid_user_attributes }, valid_session
        # ActionController::UrlGenerationError:
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
      # @request.env["devise.mapping"] = Devise.mappings[:user]
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

      @request.env["devise.mapping"] = Devise.mappings[:user]
      # @request.env["devise.mapping"] = Devise.mappings[:user]
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
      signin(@user.email, @user.password)
      # => "ok"
      # binding.pry
=begin
      --- !ruby/object:User
      raw_attributes:
      expect(user.encrypted_password).not_to eq nil
      user = User.last
      expect(user.id).to eq '1'
      expect(user.email).to eq 'test@example.com'
      expect(user.reset_password_token).to eq nil
      expect(user.reset_password_sent_at).to eq nil
      expect(user.remember_created_at).to eq nil
      expect(user.sign_in_count).to eq '1'
      expect(user.current_sign_in_at).to eq '2016-04-11 04:16:25.220083'
      expect(user.last_sign_in_at).to eq '2016-04-11 04:16:25.220083'
      expect(user.current_sign_in_ip).to eq 127.0.0.1
      expect(user.last_sign_in_ip).to eq 127.0.0.1
      expect(user.created_at).to eq '2016-04-11 04:04:10.206189'
      expect(user.updated_at).to eq '2016-04-11 04:16:25.222145'
      expect(user.name).to eq 'Test User'
      expect(user.confirmation_token).to eq nil
      expect(user.confirmed_at).to eq '2016-04-11 04:04:07.176981'
      expect(user.confirmation_sent_at).to eq nil
      expect(user.unconfirmed_email).to eq nil
      expect(user.role).to eq nil'0'
      expect(user.invitation_token).to eq nil
      expect(user.invitation_created_at).to eq nil
      expect(user.invitation_sent_at).to eq nil
      expect(user.invitation_accepted_at).to eq nil
      expect(user.invitation_limit).to eq nil
      expect(user.invited_by_id).to eq nil
      expect(user.invited_by_type).to eq nil
      expect(user.invitations_count).to eq '0'
      expect(user.provider).to eq nil
      expect(user.uid).to eq nil
      # binding.pry
      # attributes: !ruby/object:ActiveRecord::AttributeSet
      # attributes: !ruby/object:ActiveRecord::LazyAttributeHash
      # types:
      # id: &3 !ruby/object:ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Integer
      # precision:
      # scale:
      # limit:
      # range: !ruby/range
      # # begin: -2147483648
      # #   end: 2147483648
      # #   excl: true
      # email: &1 !ruby/object:ActiveRecord::Type::String
      # # precision:
      # # scale:
      # # limit:
      # encrypted_password: *1
      # reset_password_token: *1
      # reset_password_sent_at: &5 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: &2 !ruby/object:ActiveRecord::ConnectionAdapters::PostgreSQL::OID::DateTime
      # #   precision:
      # #   scale:
      # #   limit:
      # remember_created_at: &6 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # sign_in_count: *3
      # current_sign_in_at: &7 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # last_sign_in_at: &8 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # current_sign_in_ip: &4 !ruby/object:ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Inet
      # # precision:
      # # scale:
      # # limit:
      # last_sign_in_ip: *4
      # created_at: &9 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # updated_at: &10 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # name: *1
      # confirmation_token: *1
      # confirmed_at: &11 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # confirmation_sent_at: &12 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # unconfirmed_email: *1
      # role: *3
      # invitation_token: *1
      # invitation_created_at: &13 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # invitation_sent_at: &14 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # invitation_accepted_at: &15 !ruby/object:ActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter
      # # subtype: *2
      # invitation_limit: *3
      # invited_by_id: *3
      # invited_by_type: *1
      # invitations_count: *3
      # provider: *1
      # uid: *1
      # # values:
      # id: '1'
      # email: test@example.com
      # encrypted_password: "$2a$04$TOisVgBTN7g3KTiRJWs51OsGoNyQvD3SS9TDNyagP/g4.5FHNJ2ny"
      # reset_password_token:
      # reset_password_sent_at:
      # remember_created_at:
      # sign_in_count: '1'
      # current_sign_in_at: '2016-04-11 04:16:25.220083'
      # last_sign_in_at: '2016-04-11 04:16:25.220083'
      # current_sign_in_ip: 127.0.0.1
      # last_sign_in_ip: 127.0.0.1
      # created_at: '2016-04-11 04:04:10.206189'
      # updated_at: '2016-04-11 04:16:25.222145'
      # name: Test User
      # confirmation_token:
      # confirmed_at: '2016-04-11 04:04:07.176981'
      # confirmation_sent_at:
      # unconfirmed_email:
      # role: '0'
      # invitation_token:
      # invitation_created_at:
      # invitation_sent_at:
      # invitation_accepted_at:
      # invitation_limit:
      # invited_by_id:
      # invited_by_type:
      # invitations_count: '0'
      # provider:
      # uid:
      # #    additional_types: {}
      # #   materialized: true
      # #    delegate_hash:
      # encrypted_password: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: encrypted_password
      # # value_before_type_cast: "$2a$04$TOisVgBTN7g3KTiRJWs51OsGoNyQvD3SS9TDNyagP/g4.5FHNJ2ny"
      # # type: *1
      # # value: "$2a$04$TOisVgBTN7g3KTiRJWs51OsGoNyQvD3SS9TDNyagP/g4.5FHNJ2ny"
      # id: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: id
      # # value_before_type_cast: '1'
      # # type: *3
      # email: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: email
      # # value_before_type_cast: test@example.com
      # # type: *1
      # reset_password_token: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: reset_password_token
      # # value_before_type_cast:
      # # type: *1
      # reset_password_sent_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: reset_password_sent_at
      # # value_before_type_cast:
      # # type: *5
      # remember_created_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: remember_created_at
      # # value_before_type_cast:
      # # type: *6
      # sign_in_count: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: sign_in_count
      # # value_before_type_cast: '1'
      # # type: *3
      # current_sign_in_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: current_sign_in_at
      # # value_before_type_cast: '2016-04-11 04:16:25.220083'
      # # type: *7
      # last_sign_in_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: last_sign_in_at
      # # value_before_type_cast: '2016-04-11 04:16:25.220083'
      # # type: *8
      # current_sign_in_ip: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: current_sign_in_ip
      # # value_before_type_cast: 127.0.0.1
      # # type: *4
      # last_sign_in_ip: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: last_sign_in_ip
      # # value_before_type_cast: 127.0.0.1
      # # type: *4
      # created_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: created_at
      # # value_before_type_cast: '2016-04-11 04:04:10.206189'
      # # type: *9
      # updated_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: updated_at
      # # value_before_type_cast: '2016-04-11 04:16:25.222145'
      # # type: *10
      # name: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: name
      # # value_before_type_cast: Test User
      # # type: *1
      # confirmation_token: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: confirmation_token
      # # value_before_type_cast:
      # # type: *1
      # confirmed_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: confirmed_at
      # # value_before_type_cast: '2016-04-11 04:04:07.176981'
      # # type: *11
      # confirmation_sent_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: confirmation_sent_at
      # # value_before_type_cast:
      # # type: *12
      # unconfirmed_email: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: unconfirmed_email
      # # value_before_type_cast:
      # # type: *1
      # role: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: role
      # # value_before_type_cast: '0'
      # # type: *3
      # invitation_token: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invitation_token
      # # value_before_type_cast:
      # # type: *1
      # invitation_created_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invitation_created_at
      # # value_before_type_cast:
      # # type: *13
      # invitation_sent_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invitation_sent_at
      # # value_before_type_cast:
      # # type: *14
      # invitation_accepted_at: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invitation_accepted_at
      # # value_before_type_cast:
      # # type: *15
      # invitation_limit: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invitation_limit
      # # value_before_type_cast:
      # # type: *3
      # invited_by_id: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invited_by_id
      # # value_before_type_cast:
      # # type: *3
      # invited_by_type: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invited_by_type
      # # value_before_type_cast:
      # # type: *1
      # invitations_count: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: invitations_count
      # # value_before_type_cast: '0'
      # # type: *3
      # provider: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: provider
      # # value_before_type_cast:
      # # type: *1
      # uid: !ruby/object:ActiveRecord::Attribute::FromDatabase
      # # name: uid
      # # value_before_type_cast:
      # # type: *1
      # new_record: false
      # active_record_yaml_version: 0
=end
      #
      # # #
      expect(current_path).to eq '/'

      # bonus testing while we are here
      visit '/products/new'
      expect(response.status).to eq 200
      expect(response).to be_success
      expect(current_path).to eq '/products/new'
    end

    it 'populates an array of users' do # passing 20160410
      @user = FactoryGirl.build(:user, email: 'youare@example.com')
      @user.role = 'admin'
      @user.save!
      # users = User.all # unused
      expect(@users.class).to eq User::ActiveRecord_Relation

      @request.env["devise.mapping"] = Devise.mappings[:user]
      signin(@user.email, @user.password)
      expect(response.status).to eq 200
      expect(response).to be_success

      visit '/users/profile'
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Profile youare@example.com')
    end

    it 'populates an array of users' do
      pending 'not picking up current_path'
      user = FactoryGirl.build(:user, email: 'youare@example.com')
      user.role = 'admin'
      user.save!

      get :index
      expect(assigns(:teams)).to eq([team])

      users = User.all
      expect(users.class).to eq User::ActiveRecord_Relation

      sign_in(user.email, user.password)
      expect(response.status).to eq 200
      expect(response).to be_success
    end

    # Assigns are tested only in functional tests (spec/controllers)
    # http://stackoverflow.com/questions/10039253/why-i-can-not-get-current-user-while-writing-test-case-with-rspec-and-capybara
    it 'assigns @user' do # f
      @user = FactoryGirl.build(:user, email: 'youare@example.com')
      @user.role = 'admin'
      @user.save!

      get :show, @user.id.to_s
      expect(assigns(:user)).to eq(User)
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
      # @request.env["devise.mapping"] = Devise.mappings[:admin]
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
      @request.env["devise.mapping"] = Devise.mappings[:admin]
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
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      signin :user, @user # sign_in(scope, resource)

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

      @request.env["devise.mapping"] = Devise.mappings[:admin]
      signin(user.email, user.password)
      visit '/users/profile'
      expect(response).to be_success
      expect(page).to have_content(user.email)
    end
  end # is successful
end # GET #show
