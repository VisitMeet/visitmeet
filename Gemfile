source 'https://rubygems.org'
ruby '2.3.1'
gem 'rails', "4.2.6"
gem 'bcrypt' # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html'
gem 'jbuilder', "~> 2.3", ">= 2.3.1" # Create JSON structures via a Builder-style DSL
gem 'sass-rails', "~> 5.0", ">= 5.0.4" # Sass adapter for the Rails asset pipeline.
gem 'coffee-rails', "~> 4.1.0"
gem 'uglifier', "~> 2.7", ">= 2.7.2" # minifies JavaScript files by wrapping UglifyJS to be accessible in Ruby
gem 'turbolinks' # caution : this causes difficulties / failures in some situations
group :development do
  gem 'better_errors'
  gem 'hub', require: nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console', '~> 2.0'
  gem 'guard-rubocop'


end
group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails' # creates test data
  gem 'faker'
  gem 'launchy', "~> 2.4", ">= 2.4.3"
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails' # installs RSpec gems with support for Rails : Launchy requires this
  gem 'rubocop', require: false # http://www.rubydoc.info/gems/rubocop/0.36.0#Installation

end
group :test do
  gem 'capybara' # test web pages
  gem 'capybara-screenshot'
  gem 'database_cleaner' # resets db for each test, or however you set it up in spec/support/database_cleaner.yml
  gem 'selenium-webdriver' # set `js: true` for any test(s) encountering javascript handling
  gem 'simplecov', require: false # see instructions at top of spec/spec_helper.rb
end
group :production do
  gem 'rails_12factor'
end

# # Custom added Gems
# # ---- START ----
#
# # # Gemfile.lock VULNERABILITY : again being tested # # #
# https://github.com/rails/spring/commit/131287d9399990396eba74d49f6678a19d728809
# You cannot link to a git repo from your Gemfile. Spring doesn't support this
# due to the way that it gets loaded (bypassing bundler for performance reasons).
#
# Therefore, to test changes with your app,
# run `rake install` to properly install this github gem on your system.
# gem 'administrate', github: 'mariochavez/administrate', branch: 'remove-inline_svg'

# Gemfile.lock VULNERABILITY : 20160417 && 20160512
# Cross-site request forgery (CSRF) vulnerability in administrate gem
# Please consult the following and update where appropriate.
# administrate 0.1.2
#  Upgrade to: `>= 0.1.5`
# Note: 20160508 I see this github/repo was restored in master so I test it again:
# gem 'administrate', ">= 0.1.5" : this source has no vulnerability
gem 'administrate', github: 'mariochavez/administrate', branch: 'remove-inline_svg'
# 20160512 : this source from mario has a vulnerability : this is our Gemfile.lock results:
# https://isitvulnerable.com/
# https://isitvulnerable.com/results/69eea7d03bd7d259033ad780e6473fe4
# # # Gemfile.lock VULNERABILITY end of notes # # #
gem 'annotate'
gem 'bootstrap-sass'
gem 'devise'
gem 'devise_invitable'
gem 'devise-i18n'
gem 'figaro'
gem 'high_voltage'
# gem 'omniauth-github'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'simple_form'
gem 'slim-rails'
gem 'socialization'
gem 'geocoder'
gem 'gmaps4rails'         # Add google maps.
gem 'underscore-rails'
gem 'paperclip'
# code: http://docs.aws.amazon.com/sdkforruby/api/index.html
gem 'aws-sdk', "~> 2.2", ">= 2.2.31"
# gem 'mailboxer', "~> 0.13.0" # per notes below, this should be source
gem 'mailboxer', github: 'mailboxer/mailboxer'
# change ref: https://rubygems.org/gems/mailboxer/versions/0.13.0
# code: mailboxer : http://www.rubydoc.info/gems/mailboxer/0.13.0
# another change ref from above on this page :
# https://github.com/rails/spring/commit/131287d9399990396eba74d49f6678a19d728809
# You cannot link to a git repo from your Gemfile. Spring doesn't support this
# due to the way that it gets loaded (bypassing bundler for performance reasons).
#
gem 'acts_as_shopping_cart', "~> 0.2.1"
gem 'responders', "~> 2.1", ">= 2.1.2"

gem 'best_in_place', '~> 3.0.1'
gem 'jquery-rails'
gem 'jquery-ui-rails'
# # ---- END ----
