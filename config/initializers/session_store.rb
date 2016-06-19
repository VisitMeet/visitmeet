# frozen_string_literal: true
# code: config/initializers/session_store.rb
# test: to be determined
#
# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_visitmeet_session'
ActiveRecord::SessionStore::Session.attr_accessor :data, :session_id
Rails.application.config.session_store :active_record_store
