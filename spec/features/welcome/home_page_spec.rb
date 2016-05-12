# frozen_string_literal: true
# code: app/views/welcome/index.html.erb
# test: spec/features/welcome/home_page_spec.rb
#
require 'pry'
include Selectors
include Warden::Test::Helpers
Warden.test_mode!
# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page', js: true do
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
      expect(page).to have_content 'Welcome To'
      expect(page).to have_content 'VisitMeet'
    end
    within '.hometext' do
      expect(page).to have_content 'We are a not-for-profit company aimed at poverty alleviation with employments and exchanges amongst all on earth We are combining infrastructure development with travelling with world useable money'
    end
    within '.information.text-center' do
      expect(page).to have_content 'Our Information Page'
      expect(page).to have_link('Our Information Page')
    end
    within '.github' do
      expect(page).to have_link 'Github'
    end
    # expect(page).to have_link 'Our Blog' : page does not exist yet
    expect(page).to have_content 'VisitMeet, Inc.'
    expect(page).to have_content '10400 Santoc Tol, Aithpur, Ward No. 6'
    expect(page).to have_content('VisitMeet, Inc.')
    expect(page).to have_content 'Kanchanpur, MNR, Nepal 94103'
    expect(page).to have_content '+(977) 99-524-677'
    expect(page).to have_content 'VisitMeet, Inc.'
    expect(page).to have_content 'Bishisht Bhatta'
    expect(page).to have_link 'bhattabishisht@gmail.com'
    expect(page).to have_content 'We begin by offering one human product enjoyed by all who have eyes that see A NEW AWARENESS ~ arted ~'
    expect(page).to have_content 'Traveler, there is no path. Paths are made by walking.'
    expect(page).to have_content 'Antonio Machado'
  end

  scenario 'all visitors can access the sign_in page from home page' do
    expect(current_path).to eq '/'

    click_on 'Login'
    expect(current_path).to eq '/users/login'
  end

  scenario 'all visitors can access the sign_up page from home page' do
    expect(current_path).to eq root_path

    click_on 'Sign Up'
    expect(current_path).to eq '/users/sign_up'
  end

  scenario 'all visitors can access the wiki from home page' do
    expect(current_path).to eq '/'
    expect(page).to have_content 'Wiki' # => true
    expect(page).to have_link 'Wiki' # => true
    #
    # success in identifying link:
    # find(:href, 'https://github.com/VisitMeet/visitmeet/wiki')
    # => #<Capybara::Node::Element tag="a" path="/html/body/div/header/nav/div/ul[2]/li[2]/a">
    # find(:a, '/html/body/div/header/nav/div/ul[2]/li[2]/a')
    # => #<Capybara::Node::Element tag="a" path="/html/body/div/header/nav/div/ul[1]/li[2]/a">
    # (:a,    '/html/body/div/header/nav/div/ul[2]/li[2]/a') :a link identified
    # (:href, 'https://github.com/VisitMeet/visitmeet/wiki') :href to above :a
    #
    # wrong ways to test a live net link:
    # find(:href, 'https://github.com/VisitMeet/visitmeet/wiki').click
    # # ActionController::RoutingError:
    # #  No route matches [GET] "/VisitMeet/visitmeet/wiki"
    #
    # click_link 'Wiki'
    # # ActionController::RoutingError:
    # #  No route matches [GET] "/VisitMeet/visitmeet/wiki"
    #
    # # to test actual link, we need to change Selenium ?
    # visit 'https://github.com/VisitMeet/visitmeet/wiki'
    # # ActionController::RoutingError:
    # #  No route matches [GET] "/VisitMeet/visitmeet/wiki"
    #
    # expect(current_uri).to eq 'https://github.com/VisitMeet/visitmeet/wiki'
    # <a href='https://github.com/VisitMeet/visitmeet/wiki'>Our Wiki</a>
    # best test right now is to run server and hand test the link
    #
    # NEW ANSWER, now a bit old, see further below
    # http://stackoverflow.com/questions/8332262/cucumber-and-capybara-how-to-open-external-url-or-visit-outside-url
    # also : http://www.rubydoc.info/github/jnicklas/capybara/Capybara/Selenium/Driver
    # http://www.rubydoc.info/github/jnicklas/capybara/Capybara/Driver/Base
    # Capybara.app_host = 'https://github.com'
    # Capybara.run_server = false # don't start Rack
    # session.visit '/VisitMeet/visitmeet/wiki'
    #
    # Capybara.app_host = default
    # TODO: need to establish the session to finish this : 20160505
    #
    # 20160508 : checking the link exists
    expect(page).to have_link('', href: 'https://github.com/VisitMeet/visitmeet/wiki')
    #
    # NEW ANSWER, notes found and removed from Gemfile : 20160506
    # # `save_and_open_page` opens test action/errors/results in browser
    # # https://github.com/copiousfreetime/launchy : more usage examples
    # # http://www.rubydoc.info/gems/launchy/2.4.3 : same data, different format, example in a test:
    # > Launchy.open('http://visitmeet.herokuapp.com')
    Launchy.open('https://github.com/VisitMeet/visitmeet/wiki')
    # above works, now we have to switch to that browser and verify the address
    # expect(current_url).to eq 'https://github.com/VisitMeet/visitmeet/wiki'
    # # fails, showing localhost address, so we will do this another way:
    #
    expect(Capybara.current_driver).to eq :selenium
    Capybara.app_host = 'https://github.com'
    Capybara.run_server = false # don't start Rack
    visit '/VisitMeet/visitmeet/wiki'
    expect(current_url).to eq 'https://github.com/VisitMeet/visitmeet/wiki'

    Capybara.app_host = nil
    Capybara.run_server = true
  end
end
