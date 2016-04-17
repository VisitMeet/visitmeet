# frozen_string_literal: true
# app/helpers/admin/application_helper.rb
module Admin::ApplicationHelper
  # `helper_method` placed in app/controllers/application_controller.rb : reference :
  # http://stackoverflow.com/questions/4081744/devise-form-within-a-different-controller
  # helper_method :resource_name, :resource_class, :resource, :devise_mapping

  # reference for next three methods
  # also see admin_controller? method in app/controllers/application_controller.rb
  def resource_name
    @resource_name ||= if admin_controller?
      :admin_user
    else
      :user
    end
  end

  def resource
    @resource ||= resource_name.to_s.classify.constantize.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[resource_name]
  end

  # `resource_class` reference:
  # http://stackoverflow.com/questions/15348421/devise-render-sign-up-in-form-partials-elsewhere-in-code
  def resource_class
    devise_mapping.to
  end

  # next three helper methods : reference:
  # http://stackoverflow.com/questions/14866353/devise-sign-in-not-completing
  # def resource_name
  #  :user
  # end

  # def resource
  #  @resource ||= User.new
  # end

  # def devise_mapping
  #  @devise_mapping ||= Devise.mappings[:user]
  # end

  # `resource_class` reference:
  # http://stackoverflow.com/questions/15348421/devise-render-sign-up-in-form-partials-elsewhere-in-code
  # def resource_class
  #   devise_mapping.to
  # end
end