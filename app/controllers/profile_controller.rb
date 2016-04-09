# frozen_string_literal: true
# app/controllers/profile_controller.rb
# tests: spec/controllers/profile_controller_spec.rb
class ProfileController < ApplicationController
  def index
    @user = current_user
  end
end
