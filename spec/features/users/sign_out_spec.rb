# frozen_string_literal: true
# spec/features/users/sign_out_spec.rb
# these are Integration Tests, continue defining
# require 'pry'
# include Devise::TestHelpers
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
    @user = FactoryGirl.create(:user, email: 'signout@example.com')
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    # login_as(@user, scope: :user)
    # sign_in :user, @user
    signin(@user.email, @user.password)
    # TODO: WHY is the flash message not showing here + see further below
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content '× Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'

    visit '/users/profile'
    expect(page).to have_content 'VisitMeet'
    expect(page).to have_content 'Products'
    expect(page).to have_content 'Team'
    expect(page).to have_content 'Profile'
    expect(page).to have_content 'Account Settings'
    expect(page).to have_content 'Logout'
    expect(page).to have_content "signout@example.com's Profile"
    expect(page).to have_content 'signout@example.com'
    expect(page).to have_content 'Email address'
    expect(current_path).to eq '/users/profile'

    # route: destroy_user_session | DELETE | /users/logout(.:format)| devise/sessions#destroy

    click_on 'Logout'
    # visit '/users/logout'

    # # #
    # # These helpers are not going to work for integration tests driven by Capybara or Webrat.
    # # They are meant to be used with functional tests only.
    # # It is undesirable even to include Devise::TestHelpers during integration tests.
    # # Instead, fill in the form or explicitly set the user in session
    # # Sign in / Log in Test Version 1
    # # https://github.com/plataformatec/devise/
    # # Four Devise test_helper methods available
    # # sign_in :user, @user # sign_in(scope, resource)
    # # sign_in @user        # sign_in(resource)
    # # sign_out :user       # sign_out(scope)
    # # sign_out @user       # sign_out(resource)
    #
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    # sign_in @user
    #
    # use above or below, but not both
    #
    # # Sign in / Log in Test Version 2
    # # signin method in support/helpers/sessions_helper.rb
    # # signin(email, password) # template
    # @request.env["devise.mapping"] = Devise.mappings[:admin]
    # signin(@user.email, @user.password)
    # # #

    # login_as(user, scope: :user)
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    # sign_in(user.email, user.password)
    # expect(page).to have_content 'Welcome, ownprofile@example.com'
    # expect(current_path).to eq '/'
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

    # destroy_user_session(user)

    # visit '/users/logout'
    # Failure/Error: raise ActionController::RoutingError, \
    # "No route matches [#{env['REQUEST_METHOD']}] #{env['PATH_INFO'].inspect}"
    #  ActionController::RoutingError:
    #   No route matches [GET] "/users/logout"
    # SOLUTION ?

    # binding.pry
    # visit '/'
    expect(page).to have_content 'Log in'
    expect(current_path).to eq '/users/login'
    # TODO: get this next test working again:
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
