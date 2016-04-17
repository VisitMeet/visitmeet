# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routing/users_routing_spec.rb
require 'pry'
describe UsersController, type: :routing do
  describe 'routing' do
    # tests app/views/visitors/index
    # root GET / welcome#index
    it 'routes to root_path' do
      expect(get('visitors/index')).to route_to('visitors#index') # original
      # expect(get('welcome/index')).to route_to('welcome#index')
    end

    # tests app/views/profile/index.html.slim
    # profile_index GET /profile/index(.:format) profile#index
    it 'routes to profile#index' do
      expect(get('/profile/index')).to route_to('profile#index')
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

    # testing:
    # user_omniauth_authorize GET|POST /users/auth/:provider(.:format) users/omniauth_callbacks#passthru {:provider=>/github/}
    # user_omniauth_callback GET|POST /users/auth/:action/callback(.:format) users/omniauth_callbacks#(?-mix:github)

    it 'routes to user#omniauth_callbacks' do
      pending 'needs work to pass'
      expect(get('user#omniauth_callbacks')).to route_to('user/omniauth_callbacks')
      # RSpec::Expectations::ExpectationNotMetError:
      #  No route matches "/user#omniauth_callbacks"
    end
  end
end
