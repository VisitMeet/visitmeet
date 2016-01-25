class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    # Implement this in model.
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user  #, :event => :authentication #this will throw if @user is not activated
      # set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
      redirect_to products_path

    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
    flash[:notice] = "User signed in"
  end

  def failure
    redirect_to root_path
  end
end
