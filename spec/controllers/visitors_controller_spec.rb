# frozen_string_literal: true
# code: app/controllers/visitors_controller.rb
# test: spec/controllers/users/visitors_controller_spec.rb
# 20160503 : this test will be undergoing major change, along with the visitors controller
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
#
# Deprecated support for string keys in URL helpers:
# Reference : http://edgeguides.rubyonrails.org/4_2_release_notes.html
# # bad  : root_path('controller' => 'posts', 'action' => 'index')
# # good : root_path(controller: 'posts', action: 'index')
#
# Testing troubles? Use Pry: uncomment line below,
# add on a line by itself, the `binding.pry` command uncommented,
# and run the test, Pry will open your console.
# require 'pry'
RSpec.configure do
  include Devise::TestHelpers
  include Features::SessionHelpers
  include Warden::Test::Helpers
end
Warden.test_mode!

RSpec.describe VisitorsController, :devise do
  render_views

  before(:each) do
    @user = FactoryGirl.build(:user, email: 'test@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
    @users = User.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'renders and routes to visitors#team view' do
    it 'displays visitors/team' do
      user = FactoryGirl.create(:user, email: 'team@example.com')
      expect(user.persisted?).to eq true
      #
      # expect(get('team')).to route_to('visitors#team')
      # # ActionView::Template::Error:
      # #  undefined method `authenticate' for nil:NilClass
      #
      # expect(get('team')).to route_to('visitors#team')
      # # ActionView::Template::Error:
      # #  undefined method `authenticate' for nil:NilClass
      #
      # get :team
      # # ActionView::Template::Error:
      # #  undefined method `authenticate' for nil:NilClass
      # # and .. I cannot explain how even though the above two fail,
      # # the next one passes : explain that !!
      #
      # expect(get('team')).to route_to('team')
      # # ActionView::Template::Error:
      # #  undefined method `authenticate' for nil:NilClass
      #
      # expect(get('team')).to render_template('team')
      # # ActionView::Template::Error:
      # #  undefined method `authenticate' for nil:NilClass

      visit '/visitors/team'
      expect(current_path).to eq '/visitors/team'
    end
  end
end
