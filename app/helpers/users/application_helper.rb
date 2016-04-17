# frozen_string_literal: true
# app/helpers/users/application_helper.rb
module Users::ApplicationHelper
  # `helper_method` must be placed in app/controllers/application_controller.rb : reference :
  # http://stackoverflow.com/questions/4081744/devise-form-within-a-different-controller
  # helper_method :resource_name, :resource_class, :resource, :devise_mapping

  # next three helper methods : reference:
  # http://stackoverflow.com/questions/14866353/devise-sign-in-not-completing
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # `resource_class` reference:
  # http://stackoverflow.com/questions/15348421/devise-render-sign-up-in-form-partials-elsewhere-in-code
  def resource_class
    devise_mapping.to
  end
end
