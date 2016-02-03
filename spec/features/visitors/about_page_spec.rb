# encoding: utf-8
include Warden::Test::Helpers
Warden.test_mode!
# Feature: 'About' page
#   As a visitor
#   I want to visit an 'about' page
#   So I can learn more about the website
feature 'About page' do
  before(:each) do
    FactoryGirl.reload
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Visit the 'about' page
  #   Given I am a visitor
  #   When I visit the 'about' page
  #   Then I see 'About the Website'
  scenario 'Visit the about page' do
    visit '/pages/about'
    expect(current_path).to eq '/pages/about'
    expect(page).to have_content 'About the Website'
  end
end
