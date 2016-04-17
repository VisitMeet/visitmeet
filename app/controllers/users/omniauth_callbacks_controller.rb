# frozen_string_literal: true
# code: app/controllers/users/omniauth_callback_controller.rb
# tests: spec/controllers/users/omniauth_callback_controller_spec.rb
# ref: https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # Implement this in model.
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
      # redirect_to products_path ?? remove line ??
    end
  end

  def failure
    redirect_to root_path
  end
end
