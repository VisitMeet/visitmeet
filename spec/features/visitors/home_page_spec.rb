# frozen_string_literal: true
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do
  before(:each) do
    visit root_path
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see 'Welcome'
  scenario 'all visitors can arrive on home page' do
    expect(current_path).to eq '/'
  end

  scenario 'all arrived visitors can see home page content' do
    expect(current_path).to eq '/'

    within '.jumbotron h2' do
      expect(page).to have_content 'Hello World!'
      expect(page).to have_content 'Welcome to VisitMeet'
    end
    within '.hometext' do
      expect(page).to have_content 'We are a not-for-profit company aimed at poverty alleviation with employments and exchanges amongst all on earth We are combining infrastructure development with travelling with world useable money'
      expect(page).to have_link 'Our Information Page'
    end
    expect(page).to have_link 'Github'
    # expect(page).to have_link 'Our Blog' : page does not exist yet
    expect(page).to have_content 'VisitMeet, Inc.'
    expect(page).to have_content '10400 Santoc Tol, Aithpur, Ward No. 6'
    expect(page).to have_content('VisitMeet, Inc.')
    expect(page).to have_content 'Kanchanpur, MNR, Nepal 94103'
    expect(page).to have_content '+(977) 99-524-677'
    expect(page).to have_content 'VisitMeet, Inc.'
    expect(page).to have_content 'Bishisht Bhatta'
    expect(page).to have_link 'bhattabishisht@gmail.com'
    expect(page).to have_content 'We begin by offering one product, AWARENESS, arted'
  end

  scenario 'all visitors can access the sign_in page from home page' do
    expect(current_path).to eq '/'

    click_on 'Login'
    expect(current_path).to eq '/users/login'
  end

  scenario 'all visitors can access the sign_up page from home page' do
    expect(current_path).to eq '/'

    click_on 'Register'
    expect(current_path).to eq '/users/sign_up'
  end
end
