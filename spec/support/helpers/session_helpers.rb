# frozen_string_literal: true
# code: spec/support/helpers/session_helpers.rb
# used: spec/features/users/sign_in_spec.rb
#
module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_user_registration_path
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      # visit '/users/login' # or ..
      visit new_user_session_path
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      click_button 'Sign in'
    end
  end
end
