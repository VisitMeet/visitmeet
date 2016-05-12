# frozen_string_literal: true
# code: spec/factories/shopping_carts.rb
# test: spec/features/shopping_carts_spec.rb
#
# == Schema Information : last verified accurate : 20160501 at version : 20160425175528
#
# Table name: shopping_carts
# # PROBLEM ? what is missing ??
# # How can this be, the table has no useful columns besides these two:
#
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
#
FactoryGirl.define do
  factory :shopping_cart do
    # so far, nothing can be or is created
  end
end
