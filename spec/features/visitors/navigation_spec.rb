# frozen_string_literal: true
# spec/features/visitors/navigation_spec.rb
require 'pry'
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
feature 'Navigation links', :devise, js: true do
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
  scenario 'view navigation links on sign_up page' do
    visit new_user_registration_path
    expect(current_path).to eq '/users/sign_up'
    expect(page).to have_content 'VisitMeet'
    expect(page).to have_content 'Visit'
    expect(page).to have_content 'Meet'
    expect(page).to have_content 'Products'
    # expect(page).to have_content 'Services'
    expect(page).to have_content 'Register to Visit & Meet'
    expect(page).to have_content 'Already have an account? Log in'
    expect(page).to have_content 'Sign in with GitHub'
    expect(page).to have_content 'Copyright © VisitMeet 2016'

    click_on 'Login'
    expect(current_path).to eq '/users/login'
  end

  scenario 'view navigation links on home page' do
    visit root_path
    expect(current_path).to eq '/users/login'
    # expect(current_path).to eq '/welcome/index'
    expect(page).to have_link 'Login'
    within '.jumbotron h2 b' do
      expect(page).to have_content 'VisitMeet'
    end

    click_on 'Login'
    expect(current_path).to eq '/users/login'
  end

  scenario 'users login page does not display Login link' do
    visit new_user_session_path
    expect(current_path).to eq '/users/login'
    save_and_open_page
    expect(page).to have_link 'Sign up'
    expect(page).to have_link 'Login'
    expect(page).to have_content 'Login'
    expect(page).to have_link 'About'
    expect(page).to have_link 'Team'
    expect(page).to have_link 'Products'
    expect(page).to have_link 'VisitMeet'
  end
end
