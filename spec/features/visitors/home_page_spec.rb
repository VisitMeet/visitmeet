# encoding: utf-8
# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do
  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Welcome"
  scenario 'visitor can arrive on home page' do
    visit root_path
    expect(current_path).to eq '/'
    expect(page).to have_content 'Welcome'
  end

  scenario 'visitor can access the sign_in page from home page' do
    visit root_path
    expect(current_path).to eq '/'
    expect(page).to have_content 'Welcome'
    click_on 'Login' # => "/users/sign_in"
    expect(current_path).to eq '/users/sign_in'
  end
end
