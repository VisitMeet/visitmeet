# frozen_string_literal: true
# code: config/boot.rb
# test: to be determined
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
