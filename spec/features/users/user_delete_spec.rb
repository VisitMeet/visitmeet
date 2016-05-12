# frozen_string_literal: true
# code: user delete action
# test: spec/features/users/user_delete_spec.rb
#
# see NOTE ON : include Devise::TestHelpers at top of
# # spec/features/users/sign_in_spec.rb
# # include Devise::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!
# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :devise, js: true do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  # User cannot currently delete their own account : noted 20160131
  scenario 'user cannot delete own account' do
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user, email: 'destroyme@example.com')
    login_as(user, scope: :user)

    visit edit_user_registration_path(user)
    expect(current_path).to match(%r{users/edit.\d})
    expect(current_path).to eq "/users/edit.#{user.id}"
    expect(page).to have_content 'Cancel my account'

    click_link_or_button 'Cancel my account'
    page.driver.browser.switch_to.alert.accept
    # expect(page).to have_content 'Welcome'
    expect(current_path).to eq '/'
    # TODO: get this next test working again:
    # expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end
end
