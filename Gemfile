# encoding: utf-8
# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.0'
gem 'rails', '4.2.6'
gem 'bcrypt' # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html'
gem 'jbuilder', '~> 2.3', '>= 2.3.1' # Create JSON structures via a Builder-style DSL
gem 'sass-rails', '~> 5.0', '>= 5.0.4' # Sass adapter for the Rails asset pipeline.
gem 'uglifier', '~> 2.7', '>= 2.7.2' # minifies JavaScript files by wrapping UglifyJS to be accessible in Ruby
gem 'turbolinks' # caution : this causes difficulties / failures in some situations
group :development do
  gem 'better_errors'
  gem 'hub', require: nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console', '~> 2.0'
end
group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails' # creates test data
  gem 'faker'
  gem 'launchy', '~> 2.4', '>= 2.4.3' # `save_and_open_page` opens test action/errors/results in browser
  # https://github.com/copiousfreetime/launchy : more usage examples
  # http://www.rubydoc.info/gems/launchy/2.4.3 : same data, different format, example in a test:
  # > Launchy.open('http://visitmeet.herokuapp.com')
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails' # installs RSpec gems with support for Rails : Launchy requires this
  gem 'rubocop', require: false # http://www.rubydoc.info/gems/rubocop/0.36.0#Installation
end
group :test do
  gem 'capybara' # test web pages
  gem 'database_cleaner' # resets db for each test, or however you set it up in spec/support/database_cleaner.yml
  gem 'selenium-webdriver' # set `js: true` for any test(s) encountering javascript handling
  gem 'simplecov', require: false # see instructions at top of spec/spec_helper.rb
end
group :production do
  gem 'rails_12factor'
end

#                                         Custom added Gems
#                                         ---- START ----
# https://github.com/rails/spring/commit/131287d9399990396eba74d49f6678a19d728809
# You cannot link to a git repo from your Gemfile. Spring doesn't support this
# due to the way that it gets loaded (bypassing bundler for performance reasons).
#
# Therefore, to test changes with your app,
# run `rake install` to properly install this github gem on your system.
# gem 'administrate', github: 'mariochavez/administrate', branch: 'remove-inline_svg'

# Gemfile.lock VULNERABILITY : 20160417
# Cross-site request forgery (CSRF) vulnerability in administrate gem
# Please consult the following and update where appropriate.
# administrate 0.1.2
#  Upgrade to: `>= 0.1.5`
gem 'administrate', '>= 0.1.5'
gem 'annotate'
gem 'bootstrap-sass'
gem 'devise'
gem 'devise_invitable'
gem 'figaro'
gem 'high_voltage'
gem 'mandrill-api'
gem 'omniauth-github'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'simple_form'
gem 'slim-rails'
gem 'socialization'
gem 'geocoder'
gem 'gmaps4rails'
gem 'underscore-rails'
gem 'paperclip'
#
# TODO: WHY is carrierwave commented out ? : 20160417
# gem 'carrierwave'
#
# TODO: WHY is aws-sdk < ?
# gem 'aws-sdk', '< 2.0'
# change ref : https://rubygems.org/gems/aws-sdk/versions/2.2.31
# code: http://docs.aws.amazon.com/sdkforruby/api/index.html
gem 'aws-sdk', '~> 2.2', '>= 2.2.31'
gem 'mailboxer', '~> 0.13.0'
# gem 'mailboxer', github: 'mailboxer/mailboxer'
# change ref: https://rubygems.org/gems/mailboxer/versions/0.13.0
# code: mailboxer : http://www.rubydoc.info/gems/mailboxer/0.13.0
# another change ref from above on this page :
# https://github.com/rails/spring/commit/131287d9399990396eba74d49f6678a19d728809
# You cannot link to a git repo from your Gemfile. Spring doesn't support this
# due to the way that it gets loaded (bypassing bundler for performance reasons).
#
gem 'acts_as_shopping_cart', '~> 0.2.1'
#                                       ---- END ----
