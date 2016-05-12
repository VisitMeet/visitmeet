# frozen_string_literal: true
# code: app/controllers/users/omniauth_callbackcontroller.rb
# test: spec/controllers/users/omniauth_callbackcontroller_spec.rb
# ref : https://developer.github.com/v3/oauth/
# see : spec/config/oauth_spec.rb
#
# Eureka ~ Github/Omniauth Authorization callback URL:
# http://visitmeet.herokuapp.com/auth/github/callback
# TODO: verify the above page is in place at Heroku / and or our app.
#
# QUESTION: Where does this Github/Omniauth Application Description show up?
# Github/Omniauth Application Description : 'VisitMeet Omniauth Login'
# ANSWER : on the Github Sign in page : a github address
#
# QUESTION: Where is the Github/Omniauth Application Description sourced from?
# ANSWER: Owners OMNIAUTH settings page at Github
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view
#
# Regarding: NoMethodError: undefined method `authenticate!' for nil:NilClass
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
#
# require 'pry' # uncomment to activate pry debugging, using `binding.pry` line inside any test
include Warden::Test::Helpers
Warden.test_mode!

# 20160510 : need to fix this error, I found this by running the local server, and
# pressing the Sign in with Github link, this is the result:
# http://visitmeet.herokuapp.com/auth/github/callback?error=redirect_uri_mismatch&error_description=The+redirect_uri+MUST+match+the+registered+callback+URL+for+this+application.&error_uri=https%3A%2F%2Fdeveloper.github.com%2Fv3%2Foauth%2F%23redirect-uri-mismatch&state=67e82e33c27bf39a1d1a00f555dfc64aca64a30b9bdeebc1
# # The page you were looking for doesn't exist.
# #  You may have mistyped the address or the page may have moved.
# #   If you are the application owner check the logs for more information.
# #    20160510 : need to fix this error -kathyonu : bishisht
# #    Terminal shows this:
# # Started GET "/users/auth/github" for ::1 at 2016-05-10 23:18:23 -0700
# # I, [2016-05-10T23:18:23.630801 #16595]  INFO -- omniauth: (github) Request phase initiated.
# #
# # Started GET "/users/auth/github" for ::1 at 2016-05-10 23:18:24 -0700
# # I, [2016-05-10T23:18:24.279187 #16595]  INFO -- omniauth: (github) Request phase initiated.

# describe OmniauthCallbackController, type: :controller, js: true do
# describe Users::OmniauthCallbackController, type: :controller, js: true do
describe UsersController, type: :controller, js: true do
  describe 'User github login' do
    #
    # $ rake routes shows :
    # #                Prefix |  Verb   | URI Pattern                            | Controller#Action
    # user_omniauth_authorize  GET|POST | /users/auth/:provider(.:format)        | users/omniauth_callbacks#passthru {:provider=>/github/}
    # user_omniauth_callback   GET|POST | /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)
    #
    # user_omniauth_authorize  GET|POST
    # #                        /users/auth/:provider(.:format)
    # # #                      /users/omniauth_callbacks#passthru {:provider=>/github/}
    #
    # user_omniauth_callback   GET|POST
    # #                        /users/auth/:action/callback(.:format)
    # # #                      /users/omniauth_callbacks#(?-mix:github)
    #
    it 'routes to user#omniauth_callbacks' do
      pending 'this test needs work and controller needs more tests'
      expect(get('users#omniauth_callbacks#passthru')).to route_to('/users/omniauth_callbacks') # line not done
    end
  end
end
