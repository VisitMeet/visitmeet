source 'https://rubygems.org'
ruby '2.3.0'
gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
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
  # > Launchy.open("http://visitmeet.herokuapp.com")
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
# Custom added Gems
# ---- START ----
gem 'administrate'
gem 'annotate'
gem 'bootstrap-sass'
gem 'devise'
gem 'devise_invitable'
gem 'figaro'
gem 'high_voltage'
gem 'mandrill-api'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'simple_form'
gem 'slim-rails'
# ---- END ----
