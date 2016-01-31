# encoding: utf-8
# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
feature 'Navigation links', :devise do
  # Scenario: View navigation links
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "home," "sign in," and "sign up"
  scenario 'view navigation links' do
    visit root_path
    expect(current_path).to eq '/'
    expect(page).to have_content 'VisitMeet'
    expect(page).to have_content 'Login'

    click_on 'Login' # => "/users/sign_in"
    expect(current_path).to eq '/users/sign_in' # => true
  end
end
