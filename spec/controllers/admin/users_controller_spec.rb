# frozen_string_literal: true
# code: app/controllers/admin/users_controller.rb
# test: spec/controllers/admin/users_controller_spec.rb
#
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
  render_views # this little line is priceless in controller tests -ko

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

      @request.env['devise.mapping'] = Devise.mappings[:user]
      signin(user.email, user.password)
      expect(response.status).to eq 200
      expect(response).to be_success

      visit '/users/profile'
      expect(current_path).to eq '/users/profile'
      expect(page).to have_content('youare@example.com')
      # TODO: need to fix the message not showing : 20160506 -ko
      # expect(page).to have_content('Signed in successfully.')
    end

    it 'allows admin entrance to admin dasboard' do
      pending 'needs work on github modal data entry'
      expect(@user.role).to eq 'admin'

      # login_as @user

      # visit '/admin/users/admin'
      # result is a modal popup : Authentication Required
      # need to fill in User Name and Password in the modal
      # click_on 'Cancel' # need to find a way to find the modal Cancel button
      # not sure how to do this, so during tests, i hand-click Cancel buttpm
      # back to Omniauth studying
      # expect(current_url).to match(/http\:\/\/127\.0\.0\.1\:\d+\/admin/)
    end
  end
end
