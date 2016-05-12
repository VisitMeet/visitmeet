# frozen_string_literal: true
# code: app/models/user.rb
# test: spec/models/user_spec.rb : passing 20160415 kathyonu
# the following was last verified accurate 20160415 kathyonu
#
# Migrations
#
# db/migrate/20160115121043_devise_create_users.rb
# db/migrate/20160115121047_add_name_to_users.rb
# db/migrate/20160115121051_add_confirmable_to_users.rb
# db/migrate/20160115121058_add_role_to_users.rb
# db/migrate/20160115121151_devise_invitable_add_to_users.rb
# db/migrate/20160118081841_create_products.rb
# db/migrate/20160125172412_add_omniauth_to_users.rb
# db/migrate/20160303161926_create_profiles.rb
#
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  provider               :string
#  uid                    :string
#
require 'pry'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe User, type: :model do
  before(:each) { @user = User.new(email: 'user@example.com') }

  after(:each) do
    Warden.test_reset!
  end

  subject { @user }

  it { should respond_to(:email) }

  it '#email returns a string' do
    expect(@user.email).to match 'user@example.com'
  end

  it 'has a valid user factory' do
    expect(build(:user)).to be_valid

    user = FactoryGirl.create(:user, email: 'validfactory@example.com')
    expect(user.persisted?).to eq true
    expect(user.email).to_not be nil
    expect(user.email).to eq 'validfactory@example.com'
  end

  it 'has a valid user admin factory' do
    expect(build(:user)).to be_valid

    user = FactoryGirl.build(:user, email: 'validadminfactory@example.com')
    user.role = 'admin'
    user.save!
    expect(user.persisted?).to eq true
    expect(user.email).to_not be nil
    expect(user.email).to eq 'validadminfactory@example.com'
  end

  it 'is set up to fail this test so you can see the failure' do
    pending 'needs far more work to pass'
    user = FactoryGirl.build(:user, email: 'omniauthuser@example.com')
    user.role = 'user'
    user.save!
    expect(user.persisted?).to eq true
    expect(user.email).to_not be nil
    expect(user.email).to eq 'omniauthuser@example.com'
    expect(from_omniauth(auth)).to raise_error(NameError)

    visit 'users/omniauth_callbacks'
    #
    # expect(self.from_omniauth(auth)).not_to raise_error(NameError)
    # NameError:
    #  undefined local variable or method `auth' for #<RSpec::ExampleGroups::User:0x007f9625b23190>
    # Question: is our callback page set up ? why is auth failing ?
    #
    # REFERENCING : app/users/omniauth_callback_controller.rb
    # Access to VM : https://github.com/organizations/VisitMeet/settings/applications/291449
    # Access to VM : https://github.com/organizations/VisitMeet/settings/profile
    #
    # Application description    : VisitMeet Omniauth Login
    # Homepage URL               : http://visitmeet.herokuapp.com/
    # Authorization callback URL : http://visitmeet.herokuapp.com/auth/github/callback
    # # verify this page exists in master, if not create it ?
    # # verify this page has the proper codes in it
    # # Read our OAuth documentation for more information: https://developer.github.com/v3/oauth/
    #
    # COMMANDS referenced:
    # #  `GET https://github.com/login/oauth/authorize` : Redirect users to request GitHub access
    # #  `https://github.com/login/oauth/authorize?     : See this code below for more info on scope
    # #    client_id=...&
    # #     scope=user,public_repo`
    # #  `curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/user` : set the Authorization header
    # #  `POST https://github.com/login/oauth/access_token` : exchange this for an access token : see further below
    # #  `GET https://api.github.com/user?access_token=...` : see explanations further below : see next command
    # #  `curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/user` : refers to prior command
    # #  `http://visitmeet.herokuapp.com/auth/github/callback` : callback address
    # # : more ?
    # # : more ?
    #
    # Web Application Flow
    # https://developer.github.com/v3/oauth/#web-application-flow
    #
    # Non-Web Application Flow
    # https://developer.github.com/v3/oauth/#non-web-application-flow
    #
    # Redirect URLs
    # https://developer.github.com/v3/oauth/#redirect-urls
    #
    # Scopes
    # https://developer.github.com/v3/oauth/#scopes
    #
    # Common errors for the authorization request
    # https://developer.github.com/v3/oauth/#common-errors-for-the-authorization-request
    #
    # Common errors for the access token request
    # https://developer.github.com/v3/oauth/#common-errors-for-the-access-token-request
    #
    # Directing users to review their access for an application
    # https://developer.github.com/v3/oauth/#directing-users-to-review-their-access-for-an-application

    # 1.1.  Roles : OAuth defines four roles:
    #
    # # resource owner   : An entity capable of granting access to a protected resource.
    # #                    When the resource owner is a person, it is referred to as an end-user.
    # #
    # # resource server  : The server hosting the protected resources, capable of accepting
    # #                    and responding to protected resource requests using access tokens.
    # #
    # # client           : An application making protected resource requests on behalf of the
    # #                    resource owner and with its authorization.  The term "client" does not
    # #                    imply any particular implementation characteristics (e.g., whether
    # #                    the application executes on a server, a desktop, or other devices).
    # #
    # # authorization server : The server issuing access tokens to the client after successfully
    # #                        authenticating the resource owner and obtaining authorization.
    # #
    # # The interaction between the authorization server and resource server
    # # is beyond the scope of this specification.  The authorization server
    # # may be the same server as the resource server or a separate entity.
    # # A single authorization server may issue access tokens accepted by
    # # multiple resource servers.
    # # # # #
    #
    # Define: Access token : The access token allows you to make requests to the API on a behalf of a user.
    # #     : USAGE: `GET https://api.github.com/user?access_token=...`
    # #    : You can pass the token in the query params like shown above, but
    # #   :  a cleaner approach is to include it in the Authorization header:
    # #  :  `Authorization: token OAUTH-TOKEN`
    # # : For example, in curl you can set the Authorization header like this:
    # #:  `curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/user`
    # Define: Personal access token : get one if you want to sign in using github authorization
    # Define: Authorization Code Grant : https://tools.ietf.org/html/rfc6749#section-4.1
    # Define: Authorization Request : https://tools.ietf.org/html/rfc6749#section-4.1 at 4.1.1
    # Define: First contact point on our app is : http://visitmeet.herokuapp.com/githubsignupaddress?
    # Define: callbacks                         :
    # Define: callback address                  : http://visitmeet.herokuapp.com/auth/github/callback
    # Define: Passthru                          : search the word on this page
    # Define: Using access token to access the API
    # Define: Listening for API response at our designated listening page address : this is called the
    # #     :  Authorization callback URL : http://visitmeet.herokuapp.com/auth/github/callback
    # Define: application suspended
    # Define: access denied
    # Define: Redirect URI mismatch
    # Define: incorrect client credentials
    # Define: Redirect URI mismatch2
    # Define: bad verification code
    # Define: Redirect users to request GitHub access
    # #     :  https://developer.github.com/v3/oauth/#1-redirect-users-to-request-github-access
    # #     :  `GET https://github.com/login/oauth/authorize`
    # Define: `X-OAuth-Scopes` lists the scopes your token has authorized.
    # #     : `X-Accepted-OAuth-Scopes` lists the scopes that the action checks for.
    # #     : see scopes listed :
    # #     : NOTE: Your application can request the scopes in the initial redirection.
    # #     :  You can specify multiple scopes by separating them with a comma:
    # #     : `https://github.com/login/oauth/authorize?
    # #     :   client_id=...&
    # #     :   scope=user,public_repo`
    # Define: WEBHOOKS: https://github.com/organizations/VisitMeet/settings/hooks
    # #    : Webhooks allow external services to be notified when certain events happen within your repository.
    # #   : When the specified events happen, we will send a POST request to each of the URLs you provide.
    # #  : Learn more in our Webhooks Guide : https://developer.github.com/webhooks/
    # # :
    # Webhooks
    # # Events        : https://developer.github.com/webhooks/#events
    # # Payloads      : https://developer.github.com/webhooks/#payloads
    # # Ping Event    : https://developer.github.com/webhooks/#ping-event
    # # Service Hooks : https://developer.github.com/webhooks/#service-hooks
    # # note on service hooks, we are not using them, we are using webhooks.
    # # note on service hooks, Github no longer accepting new services to their services repo.

    # ref: ??
    # use OmniAuth::Builder do
    #   provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    # end
    # causes failure to run :
    #  undefined method `use' for Devise:Module (NoMethodError)

    # # # # #
    # Web Application Flow
    # https://developer.github.com/v3/oauth/#web-application-flow
    #
    # Non-Web Application Flow
    # https://developer.github.com/v3/oauth/#non-web-application-flow
    #
    # Redirect URLs
    #  https://developer.github.com/v3/oauth/#redirect-urls
    #
    # Scopes
    # https://developer.github.com/v3/oauth/#scopes
    #
    # Common errors for the authorization request
    # https://developer.github.com/v3/oauth/#common-errors-for-the-authorization-request
    #
    # Common errors for the access token request
    # https://developer.github.com/v3/oauth/#common-errors-for-the-access-token-request
    #
    # Directing users to review their access for an application
    # https://developer.github.com/v3/oauth/#directing-users-to-review-their-access-for-an-application
    # # # # #

    # Scenario: User arrives with his own Personal Access Token
    #  Feature: User uses their own access_token to gain access to VisitMeet

    # Scenario: User arrives without her own Personal Access Token
    #  Feature: User must create access_token with Github
    #      ref: You may create a personal access token for your own use or
    #           You may implement the web flow below to allow other users to authorize your application.
    # Scenario: User uses their own access_token to gain access to VisitMeet

    # Scenario: User gains access and arrives at ??
    #
    # # # # #
    # Scenario: User gains access and is redirected to ?
    #  Feature: User must have access token useable by github
    # # Define: Authorization Request : https://tools.ietf.org/html/rfc6749#section-4.1 at 4.1.1
    # # The client constructs the request URI by adding the following
    # # parameters to the query component of the authorization endpoint URI
    # # using the "application/x-www-form-urlencoded" format, per Appendix B:
    # # Appendix B: https://tools.ietf.org/html/rfc6749#appendix-B
    #
    # # response_type
    # #    REQUIRED.  Value MUST be set to "code".
    #
    # # client_id
    # #    REQUIRED.  The client identifier as described in Section 2.2.
    # #    2.2. Client Identifier : https://tools.ietf.org/html/rfc6749#section-2.2
    # #    2.3. Client Authentication : https://tools.ietf.org/html/rfc6749#section-2.3
    # #    2.3.1. Client Password : https://tools.ietf.org/html/rfc6749#section-2.3.1
    # #    # Alternatively, the authorization server MAY support including the
    # #    #    client credentials in the request-body using the following parameters:
    # #    #
    # #    # client_id
    # #    # # REQUIRED.  The client identifier issued to the client during
    # #    # # the registration process described by Section 2.2.

    # #    # client_secret
    # #    # # REQUIRED.  The client secret.  The client MAY omit the
    # #    # # parameter if the client secret is an empty string.
    # #    #
    # #
    # # redirect_uri
    # #    OPTIONAL.  As described in Section 3.1.2.
    # # # # #
    # Scenario: User gains access and then what happens ?
    # Scenario: User logs out of app
    # Scenario: User changed their access token with Github, will that affect our auth process ?
    # Scenario: User loses their access tokey, or other info required to sign in to our site, what then ?
    # Scenario: User this and ..
    # Scenario: User that

    # Scenario: User sees own profile
    #   Given I am signed in using Github Authorization, aka Omniauth
    #   When I visit the user profile page
    #   Then I see my own email address
    # scenario 'is successful, user can access profile' do
    #  pending 'we are not testing anything yet'
    #  user = FactoryGirl.build(:user, email: 'accessprofile@example.com')
    #  user.role = 'admin'
    #  user.save!
    #
    # visit '/'
    # binding.pry
    # # user_omniauth_authorize
    # #  GET|POST /users/auth/:provider(.:format)
    # #   users/omniauth_callbacks#passthru {:provider=>/github/}
    #
    # # user_omniauth_callback
    # #  GET|POST  /users/auth/:action/callback(.:format)
    # #   users/omniauth_callbacks#(?-mix:github)
    #
    # Three examples from $ `rake routes` to orient, then the two usages:
    # from $ `rake routes`:
    # # #              Prefix |     Verb | URI Pattern                     | Controller#Action
    # new_user_session        |      GET | /users/login(.:format)          | devise/sessions#new
    # user_session            |     POST | /users/login(.:format)          | devise/sessions#create
    # destroy_user_session    |   DELETE | /users/logout(.:format)         | devise/sessions#destroy
    # user_omniauth_authorize | GET|POST | /users/auth/:provider(.:format) | users/omniauth_callbacks#passthru {:provider=>/github/}
    # user_omniauth_callback  | GET|POST | /users/auth/:action/callback(.:format) | users/omniauth_callbacks#(?-mix:github)
    #
    # user_omniauth_authorize GET|POST
    # get : user_omniauth_authorize
    # or
    # visit '/users/auth/:provider(:github)'
    # or ? see https://developer.github.com/v3/oauth/#oauth
    # get :user_omniauth_callbacks_path
    # # /users/auth/:action/callback(.:format)
    # # users/omniauth_callbacks#(?-mix:github)

    # `passthru` is a Devise method that does this :
    # # render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false

    # https://developer.github.com/v3/oauth/

    # Web Application Flow

    # This is a description of the OAuth2 flow from 3rd party web sites.
    # 1. Redirect users to request GitHub access

    # `GET https://github.com/login/oauth/authorize`

    # Parameters
    # Name         | Type   | Description
    # client_id    | string | Required. The client ID you received from GitHub when you registered.
    # # https://github.com/settings/applications/new
    #
    # redirect_uri | string | The URL in your app where users will be sent after authorization.
    # # See details below about redirect urls : https://developer.github.com/v3/oauth/#redirect-urls
    #
    # scope        | string | A comma separated list of scopes.
    # # If not provided, scope defaults to an empty list of scopes for users that don't have a valid token for the app.
    # #  For users who do already have a valid token for the app, the user won't be shown the OAuth authorization page
    # #   with the list of scopes. Instead, this step of the flow will automatically complete with the same scopes
    # #    that were used last time the user completed the flow.
    #
    # state        | string | An unguessable random string.
    # # It is used to protect against cross-site request forgery attacks.
    #
    # allow_signup | string | Whether or not unauthenticated users will be offered an option to sign up for GitHub
    # # during the OAuth flow. The default is true. Use false in the case that a policy prohibits signups.
    #
    # 2. GitHub redirects back to your site
    # If the user accepts your request, GitHub redirects back to your site with a temporary code in a code parameter
    # # as well as the state you provided in the previous step in a state parameter. If the states don't match,
    # #  the request has been created by a third party and the process should be aborted.
    #
    # Exchange this for an access token:
    # `POST https://github.com/login/oauth/access_token`
    # # ref : https://developer.github.com/v3/oauth/#2-github-redirects-back-to-your-site

    # Parameters :
    # # Name        |  Type | Description
    # client_id       string  Required. The client ID you received from GitHub when you registered.
    # client_secret   string  Required. The client secret you received from GitHub when you registered.
    # code            string  Required. The code you received as a response to Step 1.
    # redirect_uri    string  The URL in your app where users will be sent after authorization.
    #                         See details below about redirect urls.
    # state           string  The unguessable random string you optionally provided in Step 1.
    #
    # Response
    # By default, the response will take the following form:
    #
    # access_token=e72e16c7e42f292c6912e7710c838347ae178b4a&scope=user%2Cgist&token_type=bearer
    #
    # You can also receive the content in different formats depending on the Accept header:
    #
    # Accept: application/json
    # {"access_token":"e72e16c7e42f292c6912e7710c838347ae178b4a", "scope":"repo,gist", "token_type":"bearer"}
    #
    # Accept: application/xml
    # <OAuth>
    #   <token_type>bearer</token_type>
    #   <scope>repo,gist</scope>
    #   <access_token>e72e16c7e42f292c6912e7710c838347ae178b4a</access_token>
    # </OAuth>

    # ref: https://developer.github.com/v3/oauth/
    # 3. Use the access token to access the API
    #
    # The access token allows you to make requests to the API on a behalf of a user.
    #
    # GET https://api.github.com/user?access_token=...
    #
    # You can pass the token in the query params like shown above,
    # # but a cleaner approach is to include it in the Authorization header
    #
    # `Authorization: token OAUTH-TOKEN`
    #
    # For example, in curl you can set the Authorization header like this:
    #
    # curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/user
    #
    #
    # Redirect URLs
    #
    # The redirect_uri parameter is optional.
    # If left out, GitHub will redirect users to the callback URL configured in the OAuth Application settings.
    # If provided, the redirect URL's host and port must exactly match the callback URL.
    # The redirect URL's path must reference a subdirectory of the callback URL.
    #
    # CALLBACK: http://example.com/path
    #
    # GOOD: http://example.com/path
    # GOOD: http://example.com/path/subdir/other
    # BAD:  http://example.com/bar
    # BAD:  http://example.com/
    # BAD:  http://example.com:8080/path
    # BAD:  http://oauth.example.com:8080/path
    # BAD:  http://example.org
    #

    # Web Application Flow
    # https://developer.github.com/v3/oauth/#web-application-flow
    #
    # Non-Web Application Flow
    # https://developer.github.com/v3/oauth/#non-web-application-flow
    #
    # Redirect URLs
    # https://developer.github.com/v3/oauth/#redirect-urls
    #
    # Scopes
    # https://developer.github.com/v3/oauth/#scopes
    #
    # Common errors for the authorization request
    # https://developer.github.com/v3/oauth/#common-errors-for-the-authorization-request
    #
    # Common errors for the access token request
    # https://developer.github.com/v3/oauth/#common-errors-for-the-access-token-request
    #
    # Directing users to review their access for an application
    # https://developer.github.com/v3/oauth/#directing-users-to-review-their-access-for-an-application
  end
end
