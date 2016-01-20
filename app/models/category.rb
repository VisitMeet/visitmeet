# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  product_id  :integer
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ActiveRecord::Base
  belongs_to :products
end
