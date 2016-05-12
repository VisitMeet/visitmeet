# frozen_string_literal: true
# code: app/controllers/users/omniauth_callbacks_controller.rb
# test: spec/config/oauth_spec.rb
# route: get '/login/oauth/authorize'
include Selectors
include Warden::Test::Helpers
Warden.test_mode!

# Feature: User uses github oauth to sign in
#   As a user
#   I want to visit sign in using github credentials
#   So I can see my personal account data
feature 'User oauth with github', type: :feature, js: true do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in with github credentials
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'is successful using github credentials to access profile' do
    githubuser = FactoryGirl.build(:user, email: 'accessprofile@example.com')
    githubuser.provider = 'github'
    githubuser.role = 'admin'
    githubuser.save!
    expect(User.last.id).to eq 1
    expect(githubuser.sign_in_count?).to eq false

    # post :create, user: user_omniauth_authorize_path(:github)
    # TODO: need more study on how to do this - ko 20160422 Happy EARTH HEART Day
    # Templates from $ bundle exec rake routes
    # user_omniauth_authorize GET|POST /users/auth/:provider(.:format) | users/omniauth_callbacks#passthru {:provider=>/github/}
    # user_omniauth_callback GET|POST  /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)

    visit '/'
    expect(page).to have_content 'Sign in with Github'
    # save_and_open_page
    # # BISHISHT : line 30 above, the `post :create, ..` line, AND below
    click_on 'Sign in with Github'
    # save_and_open_page
    # there was a redirect occuring here because our password was wrong
    # i changed the data to the correct keys located in config/local_env.yml
    # also notice the response show below, with pry, allows for no more input
    # i believe what is happening here is it is waiting for our callback address/page
    # to respond. I HAVE NO IDEA yet, if that page is set up by us, or Github,
    # nor do I know if it even exists. Here is the click_on response:
    #
    # click_on 'Sign in with Github'
    # # [1] pry(#<RSpec::ExampleGroups::UserOauthWithGithub>)> \
    # # # I, [2016-05-11T20:42:29.347317 #26426]  INFO -- omniauth: (github) Request phase initiated.
    # # => "ok"
    # # [2] pry(#<RSpec::ExampleGroups::UserOauthWithGithub>)> \
    # # # I, [2016-05-11T20:42:29.855076 #26426]  INFO -- omniauth: (github) Request phase initiated.
    # expect(current_url).to match(/github/)

    fill_in :login_field, with: ENV['GITHUB_KEY']
    fill_in :password, with: ENV['GITHUB_SECRET']
    click_on 'Sign in'
    expect(current_path).to eq '/session'
    # save_and_open_page # uncomment to see actual result, a failure
    # Bishisht: EVEN THOUGH THIS TEST PASSES, it is not a pass,
    # # and it is incomplete as this is a two step process, actually
    # # more, and we only appear to have the first step passing.
    # # - kathonu : 20160511

    # visit '/users/profile'
    # expect(current_path).to eq '/users/profile'
  end

  it 'are my notes on how to finish prior test by kathyonu' do
    expect(2 + 2).to eq 4
    # # user_omniauth_authorize GET|POST /users/auth/:provider(.:format) | users/omniauth_callbacks#passthru {:provider=>/github/}
    # # user_omniauth_callback  GET|POST /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)
    #
    # # user_omniauth_authorize GET|POST
    # get : user_omniauth_authorize
    # # or
    # visit '/users/auth/:provider(:github)'
    #
    # # /users/auth/:action/callback(.:format)
    # # users/omniauth_callbacks#(?-mix:github)
    # get :user_omniauth_callbacks_path
    #
    # `passthru` is a Devise method that does this :
    # # render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
