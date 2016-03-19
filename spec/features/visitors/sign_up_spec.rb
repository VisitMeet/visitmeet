# frozen_string_literal: true
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Sign up
#   As a visitor
#   I want to sign up
#   So I can visit protected areas of the site
feature 'Sign Up', :devise, js: true do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Visitor can sign up with valid email address and password
  #   Given I am not signed in
  #   When I sign up with a valid email address and password
  #   Then I see a successful sign up message
  scenario 'visitor can sign up with valid email address and password' do
    # TODO: I leave the pending note for now.
    # pending 'needs work, Devise message not showing on page redirected to, yet shows on edit!'
    sign_up_with('test@example.com', 'please123', 'please123')

    @user = User.last
    expect(page).to have_content "Welcome, #{@user.email}"
    # txts = [I18n.t('devise.registrations.signed_up'), I18n.t('devise.registrations.signed_up_but_unconfirmed')]
    # expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  # Scenario: Visitor cannot sign up with invalid email address
  #   Given I am not signed in
  #   When I sign up with an invalid email address
  #   Then I see an invalid email message
  scenario 'visitor cannot sign up with invalid email address' do
    sign_up_with('bogus', 'please123', 'please123')
    expect(page).to have_content ' Please review the problems below'
    expect(page).to have_content ' Email is invalid'
    expect(page).to have_content ' 8 characters minimum'
    expect(page).to have_content ' Already have an account? Log in'
  end

  # Scenario: Visitor cannot sign up without password
  #   Given I am not signed in
  #   When I sign up without a password
  #   Then I see a missing password message
  scenario 'visitor cannot sign up without password' do
    sign_up_with('test@example.com', '', '')
    expect(page).to have_content "Password can't be blank"
  end

  # Scenario: Visitor cannot sign up with a short password
  #   Given I am not signed in
  #   When I sign up with a short password
  #   Then I see a 'too short password' message
  scenario 'visitor cannot sign up with a short password' do
    sign_up_with('test@example.com', 'please', 'please')
    expect(page).to have_content ' is too short'
    expect(page).to have_content ' minimum is 8 characters'
    expect(page).to have_content ' is too short (minimum is 8 characters)'
  end

  # Scenario: Visitor cannot sign up without password confirmation
  #   Given I am not signed in
  #   When I sign up without a password confirmation
  #   Then I see a missing password confirmation message
  scenario 'visitor cannot sign up without password confirmation' do
    sign_up_with('test@example.com', 'please123', '')
    expect(current_path).to eq '/users'
    expect(page).to have_content "Password confirmation doesn't match"
  end

  # Scenario: Visitor cannot sign up with mismatched password and confirmation
  #   Given I am not signed in
  #   When I sign up with a mismatched password confirmation
  #   Then I should see a mismatched password message
  scenario 'visitor cannot sign up with mismatched password and confirmation' do
    sign_up_with('test@example.com', 'please123', 'mismatch')
    expect(page).to have_content 'Please review the problems below:'
    expect(page).to have_content "Password confirmation doesn't match"
  end

  scenario 'visitor can sign up' do
    visit root_path
    expect(current_path).to eq '/'
    # expect(page).to have_content 'Register'
    expect(page).to have_link 'Register'

    visit '/users/sign_up'
    # click_link('Register')
    expect(current_path).to eq '/users/sign_up'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Password confirmation'
    fill_in :user_email, with: 'usertwo@example.com'
    fill_in :user_password, with: 'changeme'
    fill_in :user_password_confirmation, with: 'changeme'
    expect(page).to have_content 'Register to Visit & Meet'

    click_button('Sign up')
    expect(current_path).to eq '/'

    @user = User.last
    expect(page).to have_content "Welcome, #{@user.email}"
    # TODO: get these two working again
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    # expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
  end
end
