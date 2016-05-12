# frozen_string_literal: true
# spec/models/category_spec.rb
# testing app/models/category.rb
#
# Migrations
#
# db/migrate/20160118081841_create_products.rb
# db/migrate/20160203171325_add_categories_to_product.rb
# db/migrate/20160304162459_create_categories.rb
# db/migrate/20160304162257_add_category_id_to_products.rb
# db/migrate/20160304163929_remove_category_from_products.rb
#
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
    expect(category.name).to eq 'Foods'
  end

  it 'allows a new category to be added' do
    pending 'write the code we wish we had'
    expect(2 + 2).to eq 5
  end

  it 'allows a category to be deleted' do
    pending 'write the code we wish we had'
    expect(2 * 2).to eq 5
  end

  it 'associates categories with products' do
    pending 'write the code we wish we had'
    expect(2 / 2).to eq 'what'
  end
end
