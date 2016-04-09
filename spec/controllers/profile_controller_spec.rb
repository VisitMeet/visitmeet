# frozen_string_literal: true
# spec/controllers/profile_controller_spec.rb
# tests on app/controllers/profile_controller.rb
include Devise::TestHelpers
include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe ProfileController, :devise, js: true do
  before(:each) do
    Warden.test_reset!
    FactoryGirl.reload
    @user = FactoryGirl.build(:user, email: 'youare@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'User can log in' do
    it 'renders the :profile view for Admin' do
      login_as(@user, scope: :user)
      expect(response.status).to eq 200
      expect(response).to be_success
    end
  end
end
