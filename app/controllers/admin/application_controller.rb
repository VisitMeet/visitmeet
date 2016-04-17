# frozen_string_literal: true
# app/controllers/admin/application_controller.rb
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
    # commented out the before_action as it exists elsewhere as needed : 20160412ko
    before_action :authenticate_admin!, except: ['/pages#about'] # note can be removed
    before_action :update_sanitized_params, if: :devise_controller?
    protect_from_forgery with: :exception

    # def authenticate_admin
    # # TODO: Add authentication logic here.
    # # see admin_controller? below
    # end

    # reference for next three methods
    # also see admin_controller? method in app/controllers/application_controller.rb
    def admin_controller?
      !devise_controller? and request.path =~ /^\/admin/
    end
    helper_method :admin_controller?

    # Override this value to specify the number of elements to display
    # at a time on index pages. Defaults to 20.
    def records_per_page
      params[:per_page] || 20
    end

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

    def update_sanitized_params
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) } # :coupon, :stripe_token
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :current_password) }
    end
  end
end
