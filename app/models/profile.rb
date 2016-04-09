# frozen_string_literal: true
# app/models/profile.rb
# tests: spec/models/profile_spec.rb
#
# Migrations
#
# db/migrate/20160303161926_create_profiles.rb
# db/migrate/20160305150015_add_name_to_profile.rb
# db/schema.rb
# 
# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Profile < ActiveRecord::Base
  belongs_to :user
end
