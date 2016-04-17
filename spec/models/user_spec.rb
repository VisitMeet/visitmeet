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

    user = FactoryGirl.create(:user, email: 'validadminfactory@example.com')
    user.role = 'admin'
    user.save!
    expect(user.persisted?).to eq true
    expect(user.email).to_not be nil
    expect(user.email).to eq 'validadminfactory@example.com'
  end

  it 'is set up to fail this test to see the failure' do
    pending 'needs more work to pass'
    user = FactoryGirl.create(:user, email: 'omniauthuser@example.com')
    expect(self.from_omniauth(auth)).to raise_error(NameError)
    #
    # expect(self.from_omniauth(auth)).not_to raise_error(NameError)
    # NameError:
    #  undefined local variable or method `auth' for #<RSpec::ExampleGroups::User:0x007f9625b23190>
    #
  end
end
