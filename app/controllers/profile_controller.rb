# frozen_string_literal: true
# app/controllers/profile_controller.rb
# tests: spec/controllers/profile_controller_spec.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
class ProfileController < ApplicationController
  include ActionController::Helpers

  def index
    @user = current_user
  end
end
