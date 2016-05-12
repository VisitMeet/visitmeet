# frozen_string_literal: true
# code: config/oauth.rb
# test: spec/config/oauth_spec.rb
# route: get '/login/oauth/authorize'
#
# ref : https://github.com/intridea/omniauth/wiki
# OmniAuth will configure the path /auth/:provider
# start the auth process by going to that path
# OmniAuth will return auth information to the path /auth/:provider/callback
#  if user authentication fails on the provider side, OmniAuth will catch the
#  response and then redirect the request to the path /auth/failure, passing
#  a corresponding error message in a parameter named message
Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :openid, store: OpenID::Store::Filesystem.new('/tmp')
end
