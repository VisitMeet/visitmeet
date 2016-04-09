# frozen_string_literal: true
# spec/features/users/sign_out_spec.rb
require 'pry'
include Devise::TestHelpers
# include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Sign out
#   As a user
#   I want to sign out
#   So I can protect my account from unauthorized access
feature 'Sign out', :devise, type: :feature, js: true do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User signs out successfully
  #   Given I am signed in
  #   When I sign out
  #   Then I see a signed out message
  scenario 'user signs out successfully' do
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user, email: 'signout@example.com')

       # # # 
       # # Sign in / Log in Test Version 1
       # # https://github.com/plataformatec/devise/
       # # Four Devise test_helper methods available
       # # sign_in :user, @user # sign_in(scope, resource)
       # # sign_in @user        # sign_in(resource)
       # # sign_out :user       # sign_out(scope)
       # # sign_out @user       # sign_out(resource)
       @request.env['devise.mapping'] = Devise.mappings[:user]
       sign_in @user 
       # 
       # use above or below, but not both
       #
       # # Sign in / Log in Test Version 2
       # # signin method in support/helpers/sessions_helper.rb
       # # signin(email, password) # template
       # @request.env['devise.mapping'] = Devise.mappings[:admin]
       # signin(@user.email, @user.password)
       # # #
      
      expect(current_path).to eq '/'

      sign_out @user
    # login_as(user, scope: :user)
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    # sign_in(user.email, user.password)
    expect(page).to have_content 'Welcome, ownprofile@example.com'
    expect(current_path).to eq '/'
    # TODO: get this next text working again:
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    # binding.pry
    # reference : https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
    # logout(:user)

    # visit '/users/sign_out'
    # click_on 'Logout'
    #
    # fails, with failure shown

 #   destroy_user_session(user)

    # visit '/users/logout'
    # Failure/Error: raise ActionController::RoutingError, \
    # "No route matches [#{env['REQUEST_METHOD']}] #{env['PATH_INFO'].inspect}"
    #  ActionController::RoutingError:
    #   No route matches [GET] "/users/logout"

    expect(page).to have_content 'Log in'
    expect(current_path).to eq '/users/login'
    # TODO: get this next test working again:
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
