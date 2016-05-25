# frozen_string_literal: true
# code: app/controllers/admin/application_controller.rb
# test: spec/controllers/admin/application_controller_spec.rb
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
#
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
#
module Admin
  # administer admins, products, users
  class ApplicationController < Administrate::ApplicationController
    include ActionController::Helpers
    # this line is here for testing purposes, thank you -ko
    # http_basic_authenticate_with name: ENV.fetch("ADMIN_NAME"), password: ENV.fetch("ADMIN_PASSWORD")
    # TODO: if we add pages, this next line will become unwieldy
    before_action :authenticate_admin!, except: ['/pages#about']
    before_action :update_sanitized_params, if: :devise_controller?
    protect_from_forgery with: :exception

    # def authenticate_admin
    #  redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    # end


    # authenticate_admin defined below as per the problem occured in heroku during login.
    # this solution is taken from : https://github.com/thoughtbot/administrate/issues/286

    def authenticate_admin
      redirect_to '/', alert: 'Not authorized.' unless current_user && access_whitelist
    end

    # reference for the admin_controller? method : ????
    # also see admin_controller? method in app/controllers/application_controller.rb : not there
    # something may not be correct here. TODO: needs more tests : up for grabs : 20160430 -ko
    def admin_controller?
      !devise_controller? && request.path =~ /^\/admin/
    end
    helper_method :admin_controller?

    # Override this value to specify the number of elements to display
    # at a time on index pages. Defaults to 20.
    def records_per_page
      params[:per_page] || 20
    end

    # Bishisht, these next three methods might not need to be here, 
    # and or may be incorrect and need to be tweaked. I cannot say
    # these methodes are tested : compare the four methods in this file:
    # app/helpers/admin/application_helper.rb
    def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/registrations_controller.rb
    def after_sign_in_path_for(resource)
      case current_user.role
      when 'admin'
        users_path
      when 'user'
        users_path
      when 'guide'
        users_path
      when 'traveller'
        users_path
      else
        root_path
      end
    end

    def after_sign_up_path_for(resource)
      case current_user.role
      when 'admin'
        users_path
      when 'user'
        users_path
      when 'guide'
        users_path
      when 'traveller'
        users_path
      else
        root_path
      end
    end

    def after_inactive_sign_up_path_for(resource)
      case current_user.role
      when 'admin'
        users_path
      when 'user'
        users_path
      when 'guide'
        users_path
      when 'traveller'
        users_path
      else
        root_path
      end
    end

    private

    def access_whitelist
      current_user.try(:admin?) || current_user.try(:door_super?)
    end

    def update_sanitized_params
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
      # :coupon, :stripe_token
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :current_password) }
    end
  end
end
