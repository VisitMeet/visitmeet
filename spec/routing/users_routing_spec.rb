# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routing/users_routing_spec.rb
describe UsersController, type: :routing do
  describe 'routing' do
    # tests app/views/visitors/index
    # root GET / welcome#index
    it 'routes to root_path' do
      expect(get(root_path)).to route_to('welcome#index')
    end

    it 'routes to visitors#index' do
      expect(get('visitors/index')).to route_to('visitors#index') # original
    end

    # tests app/views/profile/index.html.slim
    # profile_index GET /profile/index(.:format) profile#index
    it 'routes to profile#index' do
      expect(get('/profile/index')).to route_to('profile#index')
    end

    # tests new_user_session
    # new_user_session GET /users/login(.:format) devise/sessions#new
    it 'routes to users#login' do
      expect(get('/users/login')).to route_to('devise/sessions#new')
    end
  end
end
