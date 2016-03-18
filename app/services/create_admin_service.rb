# frozen_string_literal: true
class CreateAdminService
  def call
    User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |u|
      u.password = Rails.application.secrets.admin_password
      u.password_confirmation = Rails.application.secrets.admin_password
      u.confirmed_at
      u.admin!
    end
  end
end
