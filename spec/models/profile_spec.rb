# frozen_string_literal: true
# spec/models/profile_spec.rb
# testing app/models/profile.rb
#
# Migrations
#
# db/migrate/20160303161926_create_profiles.rb
# db/migrate/20160305150015_add_name_to_profile.rb
# db/schema.rb
#
# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Profile, type: :model do
  after(:each) do
    Warden.test_reset!
  end

  it 'has a valid factory' do
  	user = FactoryGirl.create(:user, email: 'profileme@example.com')
  	expect(user.persisted?).to eq true
    expect(FactoryGirl.build(:profile)).to be_valid

    profile = FactoryGirl.create(:profile)
    expect(profile.user_id).to eq nil
    expect(Profile.last.user_id).to eq nil
    expect(profile.persisted?).to eq true
    # TODO: 20160405 study further how to proceed on next two
    # expect(profile.name).to eq 'ProfileView'
    # expect(Profile.last.user_id).not_to eq nil
  end
end
