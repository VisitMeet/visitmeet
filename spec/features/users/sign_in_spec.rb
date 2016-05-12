# frozen_string_literal: true
# code: app/controllers/visitors_controller_spec.rb
# test: spec/features/visitors/sign_in_spec.rb
#
# # # NOTE ON : include Devise::TestHelpers
# # ref : http://stackoverflow.com/questions/27284657/undefined-method-env-for-nilnilclass-in-setup-controller-for-warden-error
# # These helpers are not going to work for integration tests driven by Capybara or Webrat.
# # They are meant to be used with functional (controller) tests only.
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
# see note above regarding Devise::TestHelpers
# include Devise::TestHelpers
# require 'pry'
include Selectors
include Features::SessionHelpers
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Sign in
#   As a user
#   I want to sign in
#   So I can visit protected areas of the site
feature 'Sign in', :devise, js: true do
  before(:each) do
    @user = FactoryGirl.build(:user)
    visit root_path
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User cannot sign in if not registered
  #   Given I do not exist as a user
  #   When I sign in with valid credentials
  #   Then I see an invalid credentials message
  scenario 'user cannot sign in if not registered' do
    expect(current_path).to eq '/'

    email = 'nononehere@example.com'
    password = 'noonehere'

    signin(email, password)
    expect(page).to have_content 'Invalid email or password.'
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'email'

    visit '/users/profile'
    expect(page).not_to have_content 'noonehere@example.com.'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content I18n.t 'devise.failure.unauthenticated', authentication_keys: 'email'
  end

  # Scenario: User can sign in with valid credentials
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with valid credentials
  #   Then I see a success message
  scenario 'user can sign in with valid credentials' do
    @user = FactoryGirl.create(:user, email: 'cansignin@example.com')
    login_as @user
    # signin(user.email, user.password)
    expect(current_path).to eq '/'
    expect(page).to have_content 'Hello World'
    expect(page).to have_content 'Paths are made by walking.'
    # TODO: get next tests working again:
    # 20160509 : are both tests below now passing
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'

    visit '/users/profile'
    expect(current_path).to eq '/users/profile'
    expect(page).to have_content @user.email.to_s
    expect(page).to have_content 'cansignin@example.com'
    # TODO: get next tests working again:
    # 20160509 : are both tests below now passing
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  end

  # Scenario: User cannot sign in with wrong email
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong email
  #   Then I see an invalid email message
  scenario 'user cannot sign in with wrong email' do
    email = 'neverinvalid@example.com'
    signin(email, @user.password)
    visit 'users/profile'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content I18n.t 'devise.failure.unauthenticated', authentication_keys: 'email'
    # expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  end

  # Scenario: User cannot sign in with wrong password
  #   Given I exist as a user
  #   And I am not signed in
  #   When I sign in with a wrong password
  #   Then I see an invalid password message
  scenario 'user cannot sign in with wrong password' do
    password = 'nevervalid'
    signin(@user.email, password)
    expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'email'

    visit 'users/profile'
    # visit users_profile_path
    # signin(@user.email, @user.password)
    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    # TODO: get this next text working again:
    # 20160509 : are both tests below now passing : no
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content I18n.t 'devise.failure.unauthenticated', authentication_keys: 'email'
  end

  scenario 'user sign_in page exists' do
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Remember me'
  end

  scenario 'user can choose to sign in with github credentials' do
    pending 'needs more work to pass the full sign in'
    visit new_user_session_path
    expect(page).to have_content 'Sign in with Github'
    expect(page).to have_link 'Sign in with Github'
    # binding.pry
    # NOTE: when the click_on occurs, the app is expecting to see:
    # :github, ENV['OMNIAUTH_APP_ID'], ENV['OMNIAUTH_APP_SECRET'], scope: 'user,public_repo'
    #
    # # #
    # from `rake routes`
    #                  Prefix |   Verb   | URI Pattern                     | Controller#Action
    # user_omniauth_authorize | GET|POST | /users/auth/:provider(.:format) | users/omniauth_callbacks#passthru {:provider=>/github/}
    # user_omniauth_callback  | GET|POST | /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)
    # # #
    # # click_on('Sign in with Github')
    # #  ActionController::RoutingError:
    # #   uninitialized constant Login
    # #  ?????????????????????????????? 20160425 where'd this come from ? -ko
    # # Start looking where the link is, the new_user_session_path page ! -ko
    # # TODO: 20160509 : UNFINISHED
    #
    # Second result, not sure what changed:
    # click_on('Sign in with Github')
    # I, [2016-04-19T08:01:28.907730 #25903]  INFO -- omniauth: (github) \
    # # Request phase initiated.
    # # ActionController::RoutingError: uninitialized constant Login
    #
    # First result:
    # click_on('Sign in with Github')
    # ActionController::RoutingError:
    # # No route matches [GET] "/login/oauth/authorize"
    #
    # first try
    # visit user_omniauth_authorize_path
    # # visit user_omniauth_authorize_path
    # # ActionController::UrlGenerationError:
    # #  No route matches {:action=>"passthru",
    # #                    :controller=>"users/omniauth_callbacks"
    # #                   } missing required keys: [:provider]
    #
    # second try
    # visit user_omniauth_authorize_path(:github)
    # # visit user_omniauth_authorize_path(:github)
    # # I, [2016-04-19T07:26:12.014027 #25537]  INFO -- omniauth: (github) \
    # #  Request phase initiated.
    # #  ActionController::RoutingError: uninitialized constant Login
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'is successful, user can access profile' do
    @user.email = 'accessprofile@example.com'
    @user.role = 'admin'
    @user.save!
    login_as @user
    visit '/users/profile'
    expect(current_path).to eq users_profile_path
    expect(current_path).to eq '/users/profile'
  end

  scenario 'user can click remember-me sign-in option' do
    @user.email = 'rememberme@example.com'
    @user.role = 'user'
    @user.save!
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Remember me'
    expect(find(:css, '#user_remember_me').set(true)).to eq 'ok'
    expect(find(:css, '#user_remember_me').set(false)).to eq 'ok'

    click_on 'Sign up'
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Register to Visit & Meet'
  end
end
