# frozen_string_literal: true
# spec/controllers/admin/users_controller_spec.rb
# These are Functional Tests for Rail Controllers testing the various actions of a single controller
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view
#
# https://www.relishapp.com/rspec/rspec-rails/docs/matchers/redirect-to-matcher
# The `redirect_to` matcher is used to specify that a request redirects to a given
# template or action. It delegates to assert_redirected_to.
#
# The `redirect_to` matcher is available in controller specs (spec/controllers)
# and request specs (spec/requests).
#
# require 'pry'
RSpec.configure do
  include Devise::TestHelpers
  include Features::SessionHelpers
  include Warden::Test::Helpers
end
Warden.test_mode!

RSpec.describe UsersController, :devise, js: true do
  before(:each) do
    @user = FactoryGirl.build(:user, email: 'tester@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
    @users = User.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'renders the users_profile' do
    it 'populates an array of users' do
      user = FactoryGirl.build(:user, email: 'youare@example.com')
      user.role = 'admin'
      user.save!
      users = User.all
      expect(users.class).to eq User::ActiveRecord_Relation

      @request.env["devise.mapping"] = Devise.mappings[:user]
      signin(@user.email, @user.password)
      expect(response.status).to eq 200
      expect(response).to be_success

      visit '/users/profile'
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Profile tester@example.com')
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
