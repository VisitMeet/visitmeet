# frozen_string_literal: true
# code: app/controllers/profile_controller.rb
# test: spec/controllers/profile_controller_spec.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
# Two routes exist:
# # get 'profile/index' : in profile controller
# # get 'users/profile' : in users controller
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
#
# study this include some more, as it makes no difference, commented out or not
include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe ProfileController, :devise, js: true do
  render_views

  before(:each) do
    @user = FactoryGirl.build(:user, email: 'admin@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'User Admin' do
    it 'can log in' do
      login_as(@user, scope: :user)
      expect(response.status).to eq 200
      expect(response).to be_success
    end

    it 'can visit the /users/profile view for Admin' do
      login_as @user
      expect(response.status).to eq 200

      visit '/users/profile'
      expect(current_path).to eq users_profile_path
    end
  end

  describe 'User can log in' do
    it 'renders the /users/profile view for User' do
      @user = FactoryGirl.build(:user, email: 'anyuser@example.com')
      @user.role = 'user'
      @user.save!
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)

      login_as(@user, scope: :user)
      expect(response.status).to eq 200
      expect(response).to be_success
    end
  end

  # TODO: double check this test after master update/merge : 20160510
  # is this test testing the right path ? using visitors/index?
  # profile/index does not exist as a view template : was that missed
  # in table creation, or is visitors/index the right path
  describe 'User admin can view /profile/index view' do
    it 'renders the visitors/index view for Admin' do
      @user.save!
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)

      login_as(@user)
      expect(response.status).to eq 200
      expect(response).to be_success
      #
      # $ rake routes shows :
      # #        Prefix | Verb | URI Pattern              | Controller#Action
      # # profile_index | GET  | /profile/index(.:format) | profile#index
      # # users_profile | GET  | /users/profile(.:format) | users#profile
      #
      # visit profile_index_path
      visit '/visitors/index'
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
    end
  end
end
