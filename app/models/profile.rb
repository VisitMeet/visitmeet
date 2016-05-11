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
# User's Profile model.
class Profile < ActiveRecord::Base
  belongs_to :user
end
