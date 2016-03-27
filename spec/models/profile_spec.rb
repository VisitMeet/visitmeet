# frozen_string_literal: true
# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
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
    expect(build(:profile)).to be_valid

    profile = FactoryGirl.create(:profile)
    expect(profile.persisted?).to eq true
  end
end
