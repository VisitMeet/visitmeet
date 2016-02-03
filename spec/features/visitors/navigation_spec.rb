include Warden::Test::Helpers
Warden.test_mode!
# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
feature 'Navigation links', :devise do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: View navigation links
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "VisitMeet," and "Login"
  scenario 'view navigation links' do
    visit new_user_registration_path
    expect(current_path).to eq '/users/sign_up'
    expect(page).to have_content 'VisitMeet'
    expect(page).to have_content 'Login'

    click_on 'Login'
    expect(current_path).to eq '/users/login'
  end
end
