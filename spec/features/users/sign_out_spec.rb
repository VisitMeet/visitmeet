# frozen_string_literal: true
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Sign out
#   As a user
#   I want to sign out
#   So I can protect my account from unauthorized access
feature 'Sign out', :devise do
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
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content 'Welcome'
    expect(current_path).to eq '/'
    # TODO: get this next text working again:
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'

    click_link 'Logout'
    expect(page).to have_content 'Welcome'
    expect(current_path).to eq '/'
    # TODO: get this next test working again:
    # expect(page).to have_content I18n.t 'devise.sessions.signed_out'
  end
end
