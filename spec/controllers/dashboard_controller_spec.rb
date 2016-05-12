# frozen_string_literal: true
# code: app/controller/dashboard_controller_spec.rb
# test: spec/controllers/dashboard_controller_spec.rb
# note: be aware there are no dashboard routes, paths etc.
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
      login_as @user
    end

    after(:each) do
      Warden.test_reset!
    end

    it 'has the ADMIN constants' do
      pending 'need to learn how to initialize and test constants'
      expect(@user.persisted?).to eq true
      # expect(DASHBOARDS).to be_an_array
      # expect(DASHBOARDS[:users]).to exist
      # expect(DASHBOARDS[:products]).to exist
      # expect(DASHBOARDS[:categories]).to exist
      # expect(ROOT_DASHBOARD).to be_an_array
      # expect(DASHBOARDS.first).to eq ROOT_DASHBOARD
    end
  end
end
