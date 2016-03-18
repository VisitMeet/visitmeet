# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # Implement this in model.
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.persisted?
      sign_in_and_redirect users_profile_path # , :event => :authentication #this will throw if @user is not activated
      # set_flash_message(:notice, :success, :kind => 'Github') if is_navigational_format?
      flash[:notice] = 'User signed in using Github'
      redirect_to products_path

    else
      session['devise.github_data'] = request.env['omniauth.auth']
      flash[:notice] = 'Complete the sign up using the form below.'
      redirect_to new_user_registration_url
      # redirect_to products_path
    end
  end

  def failure
    redirect_to root_path
  end
end
