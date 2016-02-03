include Warden::Test::Helpers
Warden.test_mode!
# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Welcome"
  scenario 'visitor can arrive on home page' do
    visit root_path
    expect(current_path).to eq '/'
    expect(page).to have_content 'Hello World!'
  end

  scenario 'visitor sign_in page exists' do
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Remember me'
    
    click_on 'Sign up'
    expect(current_path).to eq '/users/sign_up'
  end
end
