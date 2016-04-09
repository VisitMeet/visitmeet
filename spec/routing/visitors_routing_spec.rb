# frozen_string_literal: true
# spec/routing/visitors_routing_spec.rb
require 'pry'
describe VisitorsController, type: :routing do
  describe 'Visitors routing' do
    it 'routes to root_path' do
      expect(get('visitors/index')).to route_to('visitors#index')
    end

    it 'routes to visitors#index' do
      expect(get('/visitors/index')).to route_to('visitors#index')
    end

    it 'routes to visitors#team' do
      expect(get('/visitors/team')).to route_to('visitors#team')
    end   

    it 'routes to users#sign_up' do
      expect(get('/users/sign_up')).to route_to('devise_invitable/registrations#new')
    end

    it 'routes to pages#about' do
      pending 'needs work to pass'
      # high_voltage/pages#show
      # expect(get('high_voltage/pages/about')).to route_to('#about')
      expect(get('/about')).to route_to('/about')
      expect(get('').to route_to(page_path(id: 'about')))
      expect(HighVoltage.page_ids).to be_an Array
    end
  end
end
