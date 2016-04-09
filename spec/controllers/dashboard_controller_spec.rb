# frozen_string_literal: true
# spec/controllers/dashboard_controller_spec.rb
# run command : git diff spec/controllers/dashboard_controller_spec.rb
include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do
  def setup
    @controller = DashboardManifestController
  end

  describe 'DashboardManifestController', :devise, type: :controller, controller: true, live: true, js: true do
    before(:each) do
      @user = FactoryGirl.build(:user, email: 'dashboard@example.com')
      @user.role = 'admin'
      @user.save!
    end

    after(:each) do
      Warden.test_reset!
    end

    it 'has the ADMIN constants' do
      pending 'need to learn how to initialize and test constants'
      # expect(DASHBOARDS).to be_an_array
      # expect(DASHBOARDS[:users]).to exist
      # expect(DASHBOARDS[:products]).to exist
      # expect(DASHBOARDS[:categories]).to exist
      # expect(ROOT_DASHBOARD).to be_an_array
      # expect(DASHBOARDS.first).to eq ROOT_DASHBOARD
    end

    it 'allows admin entrance to admin dasboard' do
      expect(@user.role).to eq 'admin'
      # get :admin
      # need to learn how to initialize and test constants
      # expect(ROOT_DASHBOARD = DASHBOARDS.first).to be true
      # expect(current_url).to eq 'http://visitmeet.com/admin'
    end
  end
end
