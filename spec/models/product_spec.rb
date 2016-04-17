# frozen_string_literal: true
# code: app/models/product.rb
# test: spec/models/product_spec.rb
# schema.rb last confirmed accurate : 20160417 kathyonu
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
#  category_id :integer
#  latitude    :float
#  longitude   :float
#  location    :string
#  category    :integer
#  image       :string
#  image_file_name :string
#  image_content_type :string
#  image_full_size :integer
#  image_updated_at :datetime
#
#  index on category_id, name: "index_products_on_category_id", using: :btree
#  index on user_id,     name: "index_products_on_user_id",     using: :btree
#
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe Product, type: :model do
  after(:each) do
    Warden.test_reset!
  end

  it 'has a valid factory' do
    expect(build(:product)).to be_valid

    product = FactoryGirl.create(:product)
    expect(product.persisted?).to eq true
    expect(product.title).to_not be nil
    expect(product.description).to_not be nil
    expect(product.price).to_not be nil
    expect(product.category).to_not be nil
    expect(product.latitude).to_not be nil
    expect(product.longitude).to_not be nil
    expect(product.location).to_not be nil
    expect(product.category_id).to be nil
  end

  it 'should require a title' do
    expect(FactoryGirl.build(:product, title: '')).to be_invalid
  end

  it 'should not have a title more than 60 characters' do
    expect(FactoryGirl.build(:product, title: 'a' * 61)).to be_invalid
  end

  it 'should require a description' do
    expect(FactoryGirl.build(:product, description: '')).to be_invalid
  end

  it 'should not allow a description longer than 160 characters' do
    expect(FactoryGirl.build(:product, description: 'a' * 161)).to be_invalid
  end

  it 'should not allow a price greater than 99999900' do
    expect(FactoryGirl.build(:product, price: 999_999_99)).to be_invalid
  end
end
