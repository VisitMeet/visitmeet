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
    pending 'needs work to find Cancel button, Devise message not showing on page'
    user = FactoryGirl.create(:user, email: 'destroyme@example.com')
    login_as(user, scope: :user)

    visit edit_user_registration_path(user)
    expect(current_path).to eq '/users/edit.1'
    expect(page).to have_content 'Cancel my account'
    click_button 'Cancel my account'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end
end
