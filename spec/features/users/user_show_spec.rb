# frozen_string_literal: true
# rspec ./spec/features/users/user_show_spec.rb
# rspec ./spec/views/users/user_show_spec.rb
# priceless : https://github.com/jnicklas/capybara/blob/master/lib/capybara/session.rb#L27
require 'pry'
# see spec/support/selectors.rb method usages : example `find(:href, '#role-options-1')`
# include Devise::TestHelpers
# include Features::SessionHelpers
include Selectors
include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise, type: :feature, js: true do
  # let(:stripe_helper) { StripeMock.create_test_helper }

  # before { warden.set_user FactoryGirl.create(:user) }

  before(:each) do
    # FactoryGirl.reload
    # StripeMock.start
  end

  after(:each) do
    # StripeMock.stop
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = FactoryGirl.build(:user, email: 'ownprofile@example.com')
    user.role = 'admin'
    user.save!

    # login_as(user, scope: :user)
    # @request.env["devise.mapping"] = Devise.mappings[:admin]
    # login_as(user, scope: :admin)

    visit new_user_session_path
    fill_in :user_email, with: 'ownprofile@example.com'
    fill_in :user_password, with: 'please123'
    click_on 'Sign in'

    expect(page).to have_content 'Welcome, ownprofile@example.com'
    expect(page).to have_content 'Account Settings'
    expect(page).to have_content user.email
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  scenario 'admins can see other user profiles' do
    @user = FactoryGirl.build(:user, email: 'userprofile@example.com')
    @user.role = 'admin'
    @user.save!

    visit user_session_path
    fill_in :user_email, with: 'ownprofile@example.com'
    fill_in :user_password, with: 'please123'
    click_on 'Sign in'

    # login_as(user, scope: @user)
    visit users_profile_path

    expect(current_path).to eq '/users/profile'
    expect(current_path).to eq users_profile_path

    visit root_path

    @other = FactoryGirl.build(:user, email: 'otherprofile@example.com')
    @other.role = 'admin'
    @other.save!
    login_as(other, scope: @other)
    expect(current_path).to eq '/'
    expect(page).to have_content other.email

    visit '/users/profile'
    expect(current_path).to eq '/users/profile'
    expect(page).to have_content 'Hello, world!'
    expect(page).to have_content other.email

    visit users_profile_path
    expect(current_path).to eq '/users/profile'
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see that access is denied to me
  scenario 'user two cannot see another user profile' do
    # plan = stripe_helper.create_plan(id: 'silver', amount: 900)
    # expect(plan.interval).to eq 'month'

    # plan = Stripe::Plan.retrieve(id: 'silver')
    # expect(plan.id).to eq 'silver'

    # Stripe::Plan.retrieve(plan.id)
    # expect(plan.amount).to eq 900

    # card_token = StripeMock.generate_card_token(last4: '1123', exp_month: 9, exp_year: 2019)
    # customer = Stripe::Customer.create(
    #  email: 'index@example.com',
    #  source: card_token,
    #  description: 'a customer description'
    # )
    # charge = Stripe::Charge.create({
    # amount: 900,
    # currency: 'usd',
    # interval: 'month',
    # customer: customer.id,
    # description: 'Charge for index@example.com'
    # },
    # idempotency_key: '95ea4310438306ch'
    # )
    # expect(charge.customer).to eq customer.id

    # customer = Stripe::Customer.retrieve(customer.id)
    user = FactoryGirl.build(:user, email: 'index@example.com')
    # user.customer_id = customer.id
    # user.last_4_digits = '4242'
    user.role = 'admin'
    # user.role = 'silver'
    user.save!
    # expect(customer.id).to eq user.customer_id
    # expect(user.customer_id).to eq customer.id
    expect(user.id).to eq 1

    # cannot arrive as not signed in
    visit 'users/profile'
    expect(current_path).to eq '/users/login'

    # @request.env["devise.mapping"] = Devise.mappings[:admin]
    login_as(user, scope: :admin)

    # fill_in :user_email, with: 'index@example.com'
    # fill_in :user_password, with: 'please123'

    # click_on('Sign in')
    expect(current_path).to eq '/users/profile'

    # expect(page).to have_content 'Signed in successfully.'
    # expect(page).to have_content I18n.t 'devise.sessions.signed_in'

    click_link 'Logout'
    expect(current_path).to eq '/'
    expect(page).to have_link('Login')
    expect(page).to have_link('Register')

    # plans = CreatePlanService.new.call : future use
    # card_token = StripeMock.generate_card_token(last4: '1123', exp_month: 12, exp_year: 2022)
    # customer = Stripe::Customer.create(
    #   email: 'other@example.com',
    #   source: card_token,
    #   description: 'a different customer description'
    # )
    # charge = Stripe::Charge.create({
    # amount: 900,
    # currency: 'usd',
    # interval: 'month',
    # customer: customer.id,
    # description: 'Charge for fra@example.com'
    # },
    # idempotency_key: '95ea4310438306ch'
    # )
    # expect(charge.customer).to eq customer.id

    # customer = Stripe::Customer.retrieve(customer.id)

    other = FactoryGirl.build(:user, email: 'frankie@appleseed.com')
    expect(other.active_for_authentication?).to be false
    # other.customer_id = customer.id
    # other.last_4_digits = '1123'
    other.role = 'traveller'
    # other.role = 'gold'
    other.save!
    expect(other.active_for_authentication?).to be true
    expect(other.role).to eq 'traveller'
    expect(other.email).to eq 'frankie@appleseed.com'
    expect(current_path).to eq '/'
    expect(page).to have_content other.email
    expect(login_as(other, scope: :user)).to be_an Array

    login_as(other, scope: :user)
    # user is already signed in, app sees this, redirects to proper page
    visit new_user_session_path
    expect(current_path).to eq '/'
    
    # TODO: 20160328 : message is getting lost somewhere, fix it
    # expect(page).to have_content 'You are already signed in.'
    # expect(page).to have_content I18n.t 'devise.failure.already_authenticated'

    logout
    expect(user.active_for_authentication?).to be true
    expect(other.active_for_authentication?).to be true

    login_as(user, scope: :user)
    visit '/users'
    expect(current_path).to eq '/home'
    expect(user.id).to eq 1

    click_link 'Logout'
    expect(current_path).to eq '/home'

   #  visit '/users/sign_out'
    # click_link 'Log out'
    # expect(current_path).to eq '/'
    # expect(current_path).to eq root_path
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'

    # login_as(user, scope: :other) # => user params
    # login_as(other, scope: :user)
    # login_as(user, scope: :user)
    signin(other.email, other.password)
    # signin(user.email, user.password)
    expect(page).to have_content 'Account Settings'
    expect(page).to have_content 'youare@appleseed.com'
    # expect(page).to have_content 'frankie@appleseed.com'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    expect(page).to have_content 'Our Github Repo'
    expect(response).to render_template('profile/index')
    expect(page).to have_content 'Copyright © VisitMeet 2016'
    expect(current_path).to eq '/'
    expect(assigns(:users)).to eq(@users)

    # logout
    visit '/users/sign_out'
    # click_link 'Logout'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content I18n.t 'devise.sessions.signed_out'

    # we have proven both users can come and go and all is well above
    # now we have one user try to visit another user's profile below

    signin(other.email, other.password)
    expect(page).to have_content 'Account'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Signed in successfully.'
    # expect(other.role).to eq 'gold'
    current_user = User.find(2)
    expect(current_user.sign_in_count?).to be true
    expect(current_user.sign_in_count).to eq 2

    # user is not signed in, user arrives at /home, not /content/plan-name
    visit user_path(user, scope: :other)
    expect(page).to have_content 'Not authorized to view this user'
    expect(current_path).to eq '/home'

    logout
    expect(current_path).to eq '/home'

    # user signs in again
    signin(other.email, other.password)
    expect(page).to have_content 'Account'
    expect(current_path).to eq '/content/gold'
    expect(page).to have_content 'Signed in successfully.'
    # expect(other.plan_id).to eq 1
    expect(other.role).to eq 'gold'
    expect(other.email).to eq 'frankie@appleseed.com'
    current_user = User.find(2)
    expect(current_user.sign_in_count?).to be true
    expect(current_user.sign_in_count).to eq 3

    visit user_path(user, scope: :user)
    expect(current_path).to eq '/home'
    expect(current_path).to_not eq '/users/2'
    expect(user.email).to eq 'index@example.com'

    visit user_path(1)
    expect(current_path).to eq '/home'
    expect(current_url).not_to match(/denied\.$/)

    visit '/users/1'
    expect(current_path).to eq '/home'
    expect(current_url).not_to match(/denied\.$/)

    visit '/users/2'
    expect(page).to have_content 'Not authorized to view this user'

    logout
    expect(page).to have_content 'Not authorized to view this user'
    # expect(page).to have_content 'Signed out successfully.'

    visit '/home'
    expect(current_path).to eq '/home'

    # user #2 has been prevented from seeing user #1 profile
    # all is well up to this point, and everyone is signed out
    # with user #2 signed out, access to profile is not available
    visit '/users/2'
    expect(page).to have_content 'Access limited to Administrator'

    # we sign in as 'other', and attempt to visit user's profile
    signin(other.email, other.password)
    expect(current_path).to eq '/content/gold'

    # access is denied, as user #2 cannot see user #1's profile
    visit '/users/1'
    # expect(current_url).to match(/denied\.$/)
    expect(current_path).to eq '/home'

    # this will pass user to /home, as we do not show users profile
    visit user_path(2)
    expect(current_path).to eq '/home'

    # this will keep user on content/gold and issue new message
    visit new_user_session_path
    expect(current_path).to_not eq '/users/sign_in'
    expect(current_path).to eq '/content/gold'
    expect(page).to have_content 'You are already signed in.'
    expect(page).to have_content I18n.t 'devise.failure.already_authenticated'

    # logout
    # click_link 'Logout'
    visit '/users/sign_out'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Signed out successfully.'

    # both users are now signed out, we are on the root_path
    # we now 'destroy the users'
    user = {}
    other = {}

    # here we attempt to view another's profile in several ways
    visit users_path # all of these should fail, as no signed in user exists
    expect(page).to have_content 'Access limited to Administrator'

    visit users_path(user, scope: :other)
    expect(current_path).to eq '/users/sign_in'
    expect(page).to have_content 'Access limited to Administrator'

    visit user_path(2)
    expect(page).to have_content 'Access limited to Administrator'

    visit user_path(1)
    expect(page).to have_content 'Access limited to Administrator'

    visit users_path(other)
    expect(page).to have_content 'Access limited to Administrator'

    # tight as a drum
    # now, we login again as Admin user

    @user = User.first
    @user.role = 'admin'
    @user.save!
    session = Capybara::Session.new(:selenium) # => #<Capybara::Session> 
    session.login_as(@user, scope: :user)
    # session.visit users_path
    visit users_profile_path

    # session.visit '/users'
    # => Selenium::WebDriver::Error::UnknownError:
    #  Target URL /users is not well-formed.
    expect(current_path).to eq '/users'
    expect(@user.id).to eq 1
    expect(page).to have_content 'index@example.com'
    # save_and_open_page # uncomment and place anywhere to see browser
    expect(page).to have_content 'frankie@appleseed.com'
    expect(page).to have_content 'Admin'
    # expect(page).not_to have_content 'Silver' # => false : why ?
    expect(page).to have_content 'Gold'
    # expect(page).not_to have_content 'Platinum' # => false : why ?
    # expect(page).not_to have_content 'Board' # => false : why ?
    expect(page).to have_content 'Change Admin Role'
    expect(page).to have_content 'Change User Role'

    # using spec/support/selectors.rb method, we verify choices
    # Admin role exists
    session.find(:href, '#role-options-1')
    # => Capybara::ElementNotFound: Unable to find href "#role-options-1"
    find(:href, '#role-options-1')
     # => #<Capybara::Element tag="a">
    expect(find(:href, '#role-options-1')).not_to eq nil
    # Guide role exists
    find(:href, '#role-options-2') # => #<Capybara::Element tag="a">
    expect(find(:href, '#role-options-2')).not_to eq nil

    # both roles exist with their change buttons
    find(:href, '#role-options-1').text # => 'Change Admin Role'
    find(:href, '#role-options-2').text # => 'Change User Role'
    expect(find(:href, '#role-options-1').text).to eq 'Change Admin Role'
    expect(find(:href, '#role-options-2').text).to eq 'Change User Role'
    expect(page).to have_content 'Delete user'
    expect(current_path).to eq '/users'

    # works, only one can be chosen
    find(:href, '#role-options-2').click
    # => 'ok'
    # find(:href, '#role-options-1').click
    # => 'ok'
    expect(current_path).to eq '/users'
    expect(page.find('#user_role_ids_2').value).to eq '2' # => true
    expect(page.find('#user_role_ids_3').value).to eq '3' # => true
    expect(page.find('#user_role_ids_2').click).to eq 'ok' # => "ok"
    expect(page.find('#user_role_ids_3').click).to eq 'ok' # => "ok"
    expect(find('#user_role_ids_2').value).to eq '2' # => true
    expect(find('#user_role_ids_3').value).to eq '3' # => true

    # find('#role-options-1').text # Capybara::ElementNotFound: Unable to find css "#role-options-1"
    find('#role-options-2').text # => "× Change User's Role gold admin No Role Change"
    expect(find('#role-options-2').text).to eq "× Change User's Role gold admin No Role Change"

    answer = page.find('.modal-body input#user_role_ids_2').value # => "2"
    expect(page.find('.modal-body input#user_role_ids_2').value).to eq '2'
    expect(answer).to eq '2'

    # both role exist, which one is selected ?
    expect(find(:href, '#role-options-1').selected?).to be false
    expect(find(:href, '#role-options-2').selected?).to be false
    expect(find(:href, '#role-options-2').selected?).to be false

    # code source spec/support/selectors.rb
    # examples:
    # find(:href, 'google.com')
    # find(:href, 'google.com').click
    # find(:href, '#role-options-1') # => #<Capybara::Element tag="a">

    # also :
    # find("a[href='#{edit_users_path}']").click
    # page.find('.modal-body .user_role_ids.radio.inline') # fails
    # page.find('.modal-body > .user_role_ids.radio.inline') # fails
    page.find('.modal-body') # works
    page.find('.modal-body input#user_role_ids_2') # works
    page.find('.modal-body input#user_role_ids_2').click # works to choose gold
    page.find('.modal-body input#user_role_ids_3').click # works to choose admin
    page.find('.modal-body input#user_role_ids_2').click # works to choose gold
    expect(find(:css, '.modal-body input#user_role_ids_2').value.to_i).to eq 2 # => true

    integer_value = find(:css, '.modal-body input#user_role_ids_2').value.to_i # => 2
    string_value = find(:css, '.modal-body input#user_role_ids_2').value # => '2'
    value = find(:css, '.modal-body input#user_role_ids_2') # => #<Capybara::Element tag="input">
    expect(find(:css, '.modal-body input#user_role_ids_2').value.to_i).to eq 2 # => true
    expect(integer_value).to eq 2
    expect(string_value).to eq '2'

    value = find(:css, '.modal-body input#user_role_ids_3') # => #<Capybara::Element tag="input">
    expect(value.class).to eq Capybara::Node::Element
    expect(find(:css, '.modal-body input#user_role_ids_3').value.to_i).to eq 3 # => true
    expect(current_path).to eq '/users'
 
    modal = find('.modal-content .usermodal') # => #<Capybara::Element tag="div">
    expect(modal.class).to eq Capybara::Node::Element

    modal = find('.modal-footer > input.btn.btn-primary').value # => "Change Role"
    expect(modal).to eq 'Change Role'

    page.find('#user_role_ids_2').value # => "2"
    page.find('#user_role_ids_3').value # => "3"
    expect(page.find('#user_role_ids_2').value).to eq '2'
    expect(page.find('#user_role_ids_3').value).to eq '3'

    page.find('form') # => #<Capybara::Element tag="form">
    page.find('.modal-body') # => #<Capybara::Element tag="div">


    session = Capybara::Session.new(:selenium) # => #<Capybara::Session>
    id = @user.id
    session[:user_id] = id
    session.click_on('Change Role')
    # TEMPLATE : click_on('element-named', options = {} )
    # click_on('Change Role', options = current_user )
    # priceless : https://github.com/jnicklas/capybara/blob/master/lib/capybara/session.rb#L27

    # click_on('Change Role', user = { current_user } )
    # click_on('Change Role', user: current_user.to_param ) # => '2'

    # click_on('Change Role', { user => params[current_user][:id] }) # fails
    # TODO: 20160324 : this fails, but the code works: fix this line so it works.
    # 1.
    # click_on('Change Role', user: params[current_user] )
    # => NameError:
    #  undefined local variable or method `params' for #<RSpec::ExampleGroups::UserProfilePage
    # 2.
    #
    # 3.
    # click_on('Change Role', { user: params[current_user][:id] })
    # click_on('Change Role', current_user) # fails
    # find(((:css, '.modal-body input#user_role_ids_2').value).to_i).click
    # select('.modal-body > .user_role_ids.radio.inline')

    # def select_second_option(id)
    #   second_option_xpath = "//*[@id='#{id}']/option[2]"
    #   second_option = find(:xpath, second_option_xpath).text
    #   select(second_option, :from => id)
    # end

    # 'a.btn.btn-xs > #edit_user_1' do
    # within 'a[href="#role-options-1"]' do
    #  page.find('a.btn.btn-xs > #edit_user_1').click
    # end
    # expect(page).to have_selector('a', href: edit_user_path([1]))
    # within 'a.btn.btn-xs[1]' do
    #   page.find('#edit_user_1').click
    # end

    # expect(page).to have_selector('')
    #
    # expect(@session).to have_select(':user_role', selected: 'Admin')
    #
    # save_and_open_page
    click_button('Change Role', exact: true)
    click_button('Change User Role', exact: true)
    #
    fill_in :user_password, with: 'changeme'
    expect(page).to have_selector('.cancel')

    within '.cancel' do
      page.find('div.cancel > a.btn.btn-xs').click
    end

    # copied and pasted further above
    expect(page).to have_select :user_role, 'gold'
    expect(page).to have_content 'Delete user'

    visit users_path(2)
    expect(page).to have_current_path(users_path(2))
    expect(current_path).to eq '/users.2'
    expect(@user.sign_in_count?).to be true
    expect(@user.sign_in_count).to eq 2

    click_link 'Sign out'
    expect(page).to have_current_path(root_path)
    expect(current_path).to eq root_path
  end

  it 'shows notice regarding public version and user data loss' do
    visit root_path
    expect(page).to have_content 'This application is released under Public Alpha Version.'
    expect(page).to have_content 'Company is subjected to make any changes without prior notice.'
  end
end
