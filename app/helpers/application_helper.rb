# frozen_string_literal: true
# code: app/helpers/application_helper.rb
# affects: app/controllers/application_controller.rb
# 
# ######################
# SECURITY UPGRADE NOTE:
# REFERENCE: http://edgeguides.rubyonrails.org/4_1_release_notes.html
# 2.8 CSRF protection from remote <script> tags
#
# Cross-site request forgery (CSRF) protection now covers
# GET requests with JavaScript responses, too. That prevents
# a third-party site from referencing your JavaScript URL
# and attempting to run it to extract sensitive data.
#
# This means any of your tests that hit .js URLs will now
# fail CSRF protection unless they use xhr. Upgrade your tests
# to be explicit about expecting XmlHttpRequests. Instead of
# `post :create, format: :js`, switch to the explicit 
# `xhr :post, :create, format: :js`
# ######################
module ApplicationHelper
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
