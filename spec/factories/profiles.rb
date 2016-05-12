# frozen_string_literal: true
# code: app/models/profile.rb
# test: spec/factories/profiles.rb
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
FactoryGirl.define do
  factory :profile do
    user nil
    # user_id 1
    name 'any string i want it to be'
    bio 'any text i want it to be, as long as the text column is set'
  end
end
