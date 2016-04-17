# frozen_string_literal: true
# spec/features/visitors/about_page_spec.rb
include Warden::Test::Helpers
Warden.test_mode!
# Feature: 'About' page
#   As a visitor
#   I want to visit an 'about' page
#   So I can learn more about the website
feature 'About page' do
  # Scenario: Visit the 'about' page
  #   Given I am a visitor
  #   When I visit the 'about' page
  #   Then I see 'About the Website'
  scenario 'Visit the about page' do
    visit page_path('about')
    visit '/about'
    expect(current_path).to eq '/about'
    expect(page).to have_content 'About the Website'
  end
end
