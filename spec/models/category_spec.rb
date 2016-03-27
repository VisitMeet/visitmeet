# frozen_string_literal: true
# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Category, type: :model do
  after(:each) do
    Warden.test_reset!
  end

  it 'has a valid factory' do
    expect(build(:category)).to be_valid

    category = FactoryGirl.create(:category)
    expect(category.persisted?).to eq true
    expect(category.name).to_not be nil
  end
end
