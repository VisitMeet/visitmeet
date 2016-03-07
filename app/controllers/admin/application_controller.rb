# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin
    before_action :update_sanitized_params, if: :devise_controller?
    protect_from_forgery with: :exception
    helper_method :resource, :resource_name, :devise_mapping

    def authenticate_admin
      # TODO: Add authentication logic here.
    end

    # Override this value to specify the number of elements to display
    # at a time on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

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
