# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routing/profile_routing_spec.rb
describe ProfileController, type: :routing do
  describe 'routing' do
    # tests app/views/visitors/index
    # root GET / welcome#index
    it 'routes to root_path' do
      expect(get('visitors/index')).to route_to('visitors#index') # original
      # expect(get('welcome/index')).to route_to('welcome#index')
    end

    # tests app/views/profile/user
    # users_profile GET /users/profile(.:format) users#profile
    it 'routes to users#profile' do
      expect(get('/users/profile')).to route_to('users#profile')
    end

    # tests new_user_session
    # new_user_session GET /users/login(.:format) devise/sessions#new
    it 'routes to users#login' do
      expect(get('/users/login')).to route_to('devise/sessions#new')
    end
  end
end
