# frozen_string_literal: true
# Execute with --enable-frozen-string-literal-debug flag
# ruby --enable-frozen-string-literal-debug script.rb

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

require 'high_voltage'
require 'capybara/rails'
require 'capybara/rspec'
# https://github.com/mattheworiordan/capybara-screenshot
# # usage: screenshot_and_save_page
# # usage: screenshot_and_open_image
require 'capybara-screenshot'

# Capybara::Screenshot.prune_strategy = :keep_last_run

ActiveRecord::Base.connection.reconnect!

# Reference : http://stackoverflow.com/questions/11770552/
# How to get Rails.logger printing to the console/stdout when running rspec?
def log_test(message)
  Rails.logger.info(message)
  puts message
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

# Reference : http://stackoverflow.com/questions/8862967/visit-method-not-found-in-my-rspec
module RSpec
  module Core
    class ExampleGroup
      include Capybara::DSL
      include Capybara::RSpecMatchers
    end
  end
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true. Also see note on login not working with Capybara/Selenium
  # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # this RSpec method was added per Terminal response on 20140628
  # check this method next time in raise_errors, any change ? 20150611
  config.raise_errors_for_deprecations!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # config.include Devise::TestHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view

  # Ref : http://stackoverflow.com/questions/13420923/configuring-warden-for-use-in-rspec-controller-specs
  # USAGE : `before { warden.set_user FactoryGirl.create(:user) }`
  # does not work
  # config.include Warden::Test::ControllerHelpers, type: :controller

  # Translations test setup
  # https://robots.thoughtbot.com/better-tests-through-internationalization
  config.include AbstractController::Translation

  # ref: http://codecrate.com/2014/11/rspec-controllers-best-practices.html
  config.render_views

  # config.assets.precompile += %w( jquery.geocomplete.js )

  # Translations test setup
  # https://robots.thoughtbot.com/better-tests-through-internationalization
  config.include AbstractController::Translation
end
