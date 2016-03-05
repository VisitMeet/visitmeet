# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category    :integer
#  latitude    :float
#  longitude   :float
#  location    :string
#  category_id :integer
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  it "should require a title" do 
    expect(FactoryGirl.build(:product, title: '')).to be_invalid
  end

  it "should not have a title more than 60 characters" do
    expect(FactoryGirl.build(:product, title: 'a' * 61)).to be_invalid
  end

  it "should require a description" do
    expect(FactoryGirl.build(:product, description: '')).to be_invalid
  end

  it "should not allow a description longer than 160 characters" do
    expect(FactoryGirl.build(:product, description: 'a' * 161)).to be_invalid
  end

  it "should not allow a price greater than 20" do
    expect(FactoryGirl.build(:product, price: 21)).to be_invalid
  end
end
