# frozen_string_literal: true
# code:
# test: spec/routing/visitors_routing_spec.rb
# from $ `rake routes`:
# #         Prefix | Verb | URI Pattern               | Controller#Action
# #  profile_index | GET  | /profile/index(.:format)  | profile#index
# #  users_profile | GET  | /users/profile(.:format)  | users#profile
# # visitors_index | GET  | /visitors/index(.:format) | visitors#index
# #  visitors_team | GET  | /visitors/team(.:format)  | visitors#team
# #    pages_about | GET  | /pages/about(.:format)    | high_voltage/pages#show {:id=>"about"}
#
describe VisitorsController, type: :routing do
  describe 'Visitors routing' do
    it 'routes to root_path' do
      expect(get('/')).to route_to('welcome#index')
    end

    it 'routes to visitors#index' do
      expect(get('/visitors/index')).to route_to('visitors#index')
    end

    it 'routes to visitors#team' do
      expect(get('/visitors/team')).to route_to('visitors#team')
    end

    # The recognized options:
    #  <{"controller"=>"devise_invitable/registrations", "action"=>"new"}>
    it 'routes to users#sign_up' do
      expect(get('/users/sign_up')).to route_to('devise_invitable/registrations#new')
    end

    # only way to delete visitors is via console
    it 'routes to #destroy' do
      expect(delete('/visitors/1')).not_to route_to('visitors#destroy', id: '1')
    end
  end
end
