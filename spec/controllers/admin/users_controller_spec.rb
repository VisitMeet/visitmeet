# frozen_string_literal: true
# spec/controllers/admin/users_controller_spec.rb
# These are Functional Tests for Rail Controllers testing the various actions of a single controller
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view
# require 'pry'
# include Devise::TestHelpers
include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!

describe UsersController, :devise, js: true do
  before(:each) do
    # StripeMock.start
    @user = FactoryGirl.build(:user, email: 'test@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
    @users = User.all
  end

  after(:each) do
    # StripeMock.stop
    Warden.test_reset!
  end

  describe 'Visit users_profile' do
    it 'populates an array of users' do
      user = FactoryGirl.build(:user, email: 'youare@example.com')
      user.role = 'admin'
      user.save!
      users = User.all
      expect(users.class).to eq User::ActiveRecord_Relation

      @request.env['devise.mapping'] = Devise.mappings[:user]
      signin(@user.email, @user.password)
      expect(response.status).to eq 200
      expect(response).to be_success

      visit '/users/profile'
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Profile test@example.com')
    end
  end
end