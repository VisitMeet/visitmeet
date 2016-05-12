# frozen_string_literal: true
# app/models/profile.rb
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
# User's Profile model.
class Profile < ActiveRecord::Base
  belongs_to :user
end
