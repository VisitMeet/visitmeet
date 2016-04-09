# frozen_string_literal: true
# spec/controllers/profile_controller_spec.rb
# testing: app/controllers/profile_controller.rb
#
# Two routes exist:
# # get 'profile/index'
# # get 'users/profile'
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
include Warden::Test::Helpers
Warden.test_mode!

describe ProfileController, :devise, js: true do
  before(:each) do
    Warden.test_reset!
    FactoryGirl.reload
    @user = FactoryGirl.build(:user, email: 'youare@example.com')
    @user.role = 'admin' # using Enum for roles
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'User can log in' do
    it 'renders the /users/profile view for Admin' do
      @user.save!
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)

      login_as(@user, scope: :user)
      expect(response.status).to eq 200
      expect(response).to be_success
    end

    it 'renders the profile index view for Admin' do
      @user.save!
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)

      sign_in @user
      expect(response.status).to eq 200
      expect(response).to be_success

      get :index, @user.id.to_s
      expect(response.status).to eq 200
      expect(response).to have_http_status(:ok)
    end
  end
end
