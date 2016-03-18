# frozen_string_literal: true
require 'devise/orm/active_record'
Devise.setup do |config|
  config.secret_key = '52dac4f72ad586f5ad66c3eb6b3456c1dbb6c597e3781c16613af1f386bfe4b1245a7583886675681c8ff9225bad2435998b6daa0acd655647afe43e7dd71bca'
  config.mailer_sender = 'VisitMeet <narmadainfosys@mail.com>'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.send_password_change_notification = false
  config.invite_for = 2.weeks
  config.invitation_limit = nil
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..60
  config.unlock_strategy = :email
  config.maximum_attempts = 4
  config.last_attempt_warning = true
  config.reset_password_within = 6.hours
  config.sign_out_via = :get

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  config.omniauth :github, '97ef5b4212154f75e8f6', 'ebe3766550855ca09b9ce311ed1f76c456359dc5', scope: 'user,public_repo'
end
