# frozen_string_literal: true
# code: app/views/pages/about.html.erb
# code: spec/support/selectors.rb
# test: spec/features/visitors/about_page_spec.rb
#
include Selectors
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
    expect(page).to have_selector('#twowhales')
    # TODO: Write the xpath finder to verify the 'alt' text is 'Two Whales'
    # TODO: Write the xpath finder to verify the image address is 'two-whales.jpg'
    # TODO: Write the xpath finder to verify the 'class' is 'img-responsive'
    # <%= image_tag('two-whales.jpg', class: 'img-responsive',
    #                                height: '468',
    #                                width: '459',
    #                                alt: 'Two Whales'
    # ) %>
    # We are not displaying the image title:
    expect(page).not_to have_content 'Two Whales'
    expect(page).to have_content 'What About VisitMeet . . that makes it unique'
    expect(page).to have_content 'Three strangers meet and visit . .'
    expect(page).to have_content 'and in what you might consider a middle of nowhere,'
    expect(page).to have_content 'they share their story of how they came to be at that roadside cafe.'
    expect(page).to have_content 'A native born asked the two strangers that question.'
    expect(page).to have_content 'One was a Guide for a tour company, and the other the Traveller.'
    expect(page).to have_selector('#twowhales')
  end
end
