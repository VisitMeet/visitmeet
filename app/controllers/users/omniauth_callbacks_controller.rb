# frozen_string_literal: true
# code: app/controllers/users/omniauth_callback_controller.rb
# tests: spec/controllers/users/omniauth_callback_controller_spec.rb
#
# see : app/controllers/application_controller.rb
#
# ref: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
# Template in config/routes.rb:
# # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
#
# IMPORTANT ERROR DATA : 20160502 : Bishisht
# # http://visitmeet.herokuapp.com/auth/github/callback
# #  ?error=redirect_uri_mismatch
# #   &error_description=The+redirect_uri+MUST+match+the+registered+callback+URL+for+this+application.
# #    &error_uri=https%3A%2F%2Fdeveloper.github.com%2Fv3%2Foauth%2F%23redirect-uri-mismatch&state=5383b00truncated
#
module Users
  # using github authoriztion
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
      # Implement this in model : see ref above
      user = User.from_omniauth(request.env['omniauth.auth'])

      if user.persisted?
        # reference regarding `:event => :authentication` option
        # http://stackoverflow.com/questions/9221390/what-does-event-authentication-do/13389324#13389324
        sign_in_and_redirect users_profile_path # , :event => :authentication # this will throw if @user is not activated
        # set_flash_message(:notice, :success, :kind => 'Github') if is_navigational_format? # reference source code
        flash[:notice] = 'User signed in using Github' # not reference source code
        redirect_to products_path
      else
        session['devise.github_data'] = request.env['omniauth.auth']
        flash[:notice] = 'Complete the sign up using the form below.'
        redirect_to new_user_registration_url
      end
    end

    def twitter
      # Implement this in model : see ref above
      user = User.from_omniauth(request.env['omniauth.auth'])

      if user.persisted?
        # reference regarding `:event => :authentication` option
        # http://stackoverflow.com/questions/9221390/what-does-event-authentication-do/13389324#13389324
        sign_in_and_redirect users_profile_path # , :event => :authentication # this will throw if @user is not activated
        # set_flash_message(:notice, :success, :kind => 'Github') if is_navigational_format? # reference source code
        flash[:notice] = 'User signed in using Twitter' # not reference source code
        redirect_to products_path
      else
        session['devise.twitter_data'] = request.env['omniauth.auth']
        flash[:notice] = 'Complete the sign up using the form below.'
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end

    # DEVISE METHOD available for use in TRANSLATIONS
    # ref: https://github.com/plataformatec/devise/blob/master/app/controllers/devise/omniauth_callbacks_controller.rb
    # # def translation_scope
    # #   'devise.omniauth_callbacks'
    # # end
  end
end
