# frozen_string_literal: true
# spec/controllers/users_controller_spec.rb
RSpec.configure do
  # include Devise::TestHelpers
  include Features::SessionHelpers
  include Warden::Test::Helpers

  def setup
    @controller = UsersController.new
  end

  Warden.test_mode!
end

describe UsersController, :devise, js: true do
  render_views

  before(:each) do
    Warden.test_reset! # leave it
    @user = FactoryGirl.build(:user)
    @user.role = 'admin' # using Enum for roles
    @user.save!
    @users = User.all
  end

  after(:each) do
    Warden.test_reset!
  end

  describe 'Visit users_profile' do
    it 'renders the :profile view for Admin' do
      pending 'not picking up visit method'
      sign_in(@user.email, @user.password)

      visit '/users/profile'
      expect(response.status).to eq 200
      expect(response).to be_success
      expect(current_path).to eq '/users/profile'
    end

    it 'populates an array of users' do
    end

    it 'assigns @users' do
      pending 'not picking up visit method'
      # TODO: this test is not assigning anything as written
      user = FactoryGirl.build(:user, email: 'youare@example.com')
      user.role = 'admin'
      user.save!

      users = User.all
      expect(users.class).to eq User::ActiveRecord_Relation
      expect(users.size).to eq 2

      sign_in(user.email, user.password)
      expect(User.all.size).to eq 2
      expect(user.id).to eq 2
      expect(user.email).to eq 'youare@example.com'
      expect(user.persisted?).to eq true

      users = User.all
      expect(users.size).to eq 2
      visit '/users/profile'
      expect(response.status).to eq 200
      expect(current_path).to eq '/users/profile'
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'is successful' do
      pending 'not picking up current_path'
      @user = FactoryGirl.build(:user, email: 'youare@example.com')
      @user.role = 'admin'
      @user.save!
      @users = User.all
      expect(@users.class).to eq User::ActiveRecord_Relation
      expect(@user._validators?).to eq true

      login_as @user
      # sign_in(user.email, user.password)
      expect(current_path).to eq '/users'

      visit '/users/1'
      expect(Rails.logger.info(response.body)).to eq true
      expect(Rails.logger.warn(response.body)).to eq true
      expect(Rails.logger.debug(response.body)).to eq true
      expect(response).to be_success
    end

    it 'finds the right user' do
      pending 'not picking up visit method'
      @user = FactoryGirl.build(:user, email: 'newuser@example.com')
      @user.role = 'admin'
      @user.save!
      @request.env["devise.mapping"] = Devise.mappings[:user]
      # signin(@user.email, @user.password)
      sign_in(@user.email, @user.password)
      visit '/users/profile'
      expect(response).to be_success
      expect(page).to have_content(user.email)
    end
  end
end
