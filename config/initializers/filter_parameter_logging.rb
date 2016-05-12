# frozen_string_literal: true
# code: config/initializers/filter_parameter_loggin.rb
# test: sign_in and sign_up tests use this and so test it
#
# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]
