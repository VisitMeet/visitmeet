# frozen_string_literal: true
# code: app/models/profile.rb
# also: spec/factories/profiles.rb
# test: spec/models/profile_spec.rb
#
# Migrations : last verified accurate : 20160422 ko
# # db/migrate/20160303161926_create_profiles.rb
# # db/migrate/20160305150015_add_name_to_profile.rb
# # db/migrate/20160412165928_add_bio_to_profile.rb
# # db/schema.rb
#
# == Schema Information
# Table name: profiles
#  id         :integer          not null, primary key
#  name       :string
#  bio        :text
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

    profile = FactoryGirl.create(
      :profile, user_id: 1,
                name: 'any string i want it to be',
                bio: 'any text i want it to be, as long as the text column is set'
    )
    expect(profile.user_id).to eq 1
    expect(Profile.last.user_id).not_to eq nil
    expect(Profile.last.user_id).to eq 1
    expect(profile.name).to eq 'any string i want it to be'
    expect(profile.persisted?).to eq true
    expect(profile.bio).to eq 'any text i want it to be, as long as the text column is set'
  end
end
