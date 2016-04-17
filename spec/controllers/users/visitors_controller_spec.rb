# frozen_string_literal: true
# codes: app/controllers/users/visitors_controller.rb
# tetsting spec/controllers/users/visitors_controller_spec.rb
# run command $ rspec spec/controllers/users/visitors_controller_spec.rb
# run command $ git diff spec/controllers/users/visitors_controller_spec.rb
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
#
# Testing troubles? Use Pry: uncomment line below,
# add on a line by itself, the
# `binding.pry` command uncommented,
# and run the test, Pry will open your console.
require 'pry'
RSpec.configure do
  include Devise::TestHelpers
  include Features::SessionHelpers
  include Warden::Test::Helpers
end
Warden.test_mode!

RSpec.describe VisitorsController, :devise do
  before(:each) do
    @user = FactoryGirl.build(:user, email: 'test@example.com')
    @user.role = 'admin' # using Enum for roles
    @user.save!
    @users = User.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'renders the users profile index' do
    it 'routes to root_path' do
      user = FactoryGirl.create(:user, email: 'yourroot@example.com')
      expect(user.persisted?).to eq true
      expect(get('index')).to route_to('visitors#index')
    end

    it 'populates an array of users' do
      user = FactoryGirl.create(:user, email: 'yourarray@example.com')
      expect(user.persisted?).to eq true

      env[‘warden’].authenticate! 
      get :index
      expect(response).to render_template('index')
    end

    it 'routes to visitors#team' do
      user = FactoryGirl.create(:user, email: 'team@example.com')
      expect(user.persisted?).to eq true
      expect(get('team')).to route_to('visitors#team')

      env[‘warden’].authenticate! 
      get :team
      expect(response).to render_template('')
    end
  end
end
