# frozen_string_literal: true
# spec/controllers/products_controller_spec.rb
# testing app/controllers/products_controller.rb
# These are Functional Tests for Rail Controllers testing the various actions of a single controller
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view
require 'pry'
RSpec.configure do
  include Devise::TestHelpers
  include Features::SessionHelpers
  include Warden::Test::Helpers

  def setup
    @controller = ProductsController.new
    @product = FactoryGirl.create(:product)
    @products = Product.all
  end

  Warden.test_mode!
end

describe ProductsController, :devise, type: :controller, controller: true, js: true do
  before(:each) do
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'GET #show' do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @user.role = 'admin'
      @user.save!
    end

    it 'is successful' do
      get :show, @product.id
      # get :show, @product
      # ActionController::UrlGenerationError:
      #  No route matches {:action=>"show", :controller=>"products"}
    end
    # future use
    # it 'returns a PDF file for the Admin' do
    #   @user.save!
    #   login_as(@user, scope: :user)
    #   visit '/home'
    #   expect(response.status).to eq 200
    #   expect(current_path).to eq '/home'
    #   expect(page).to have_content 'Products Listed'

    #   click_link_or_button('Download PDF')
    #   expect(response.status).to eq 200
    #   page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
    #   page do
    #     click_on 'OK'
    #   end
    #   # page.driver.browser.close
    #   # page.driver.browser.switch_to.window(page.driver.browser.window_handles[0])

    #   # switch_to_new_pop_up : see spec/support/modal_helpers.rb
    #   # page.switch_to_new_pop_up(page.driver.browser.switch_to.window(page.driver.browser.window_handles.last))
    #   # page.new_window(win) do
    #   #   click_on 'OK'
    #   # end
    #   # new_window=page.driver.browser.window_handles.last
    #   # win = page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
    #   #    #    expect(response.headers['Content-Type']).to eq('text/html')
    #   # close_active_window # method in support/helpers/modal_helpers
    # end

    # it 'returns a PDF file for the signed in User' do
    #   @user.role = 'traveller'
    #   expect(@user.role).to eq 'traveller'

    #   @user.save!
    #   login_as(@user, scope: :user)
    #   visit '/users/profile'
    #   expect(response.status).to eq 200
    #   expect(current_path).to eq users_profile_path
    #   expect(page).to have_content 'VisitMeet'
    #   expect(page).to have_content 'Welcome!'

    #   click_link_or_button 'VisitMeet'
    #   expect(current_path).to eq '/'
    #   # page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
    #   # page do
    #   #  click_on 'OK'
    #   # end
    #   expect(response.status).to eq 200

    #   # page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
    #   # page.driver.browser.switch_to.alert.accept
    #   # expect(response.status).to eq 200
    #   # expect(current_path).to eq '/content/silver'
    #   expect(response.header['X-Frame-Options']).to eq 'SAMEORIGIN'
    #   expect(response.request.cookies).to eq({}) # TODO: one day, i shall test my cookies
    #   expect(response.request.env[:HTTPS]).to eq nil
    #   expect(response.request.env['action_dispatch.secret_key_base']).to match(/^79cfa.+/)
    #   expect(response.request.filtered_parameters.count).to eq 0
    #   expect(response.request.filtered_parameters).to be_a(Hash)
    #   expect(response.request.request_method).to eq 'GET'
  end
end
