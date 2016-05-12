# frozen_string_literal: true
# code: config/initializers/i18n.rb
# test: to be determined
#
if Rails.env.development? || Rails.env.test?
  I18n.exception_handler = lambda do |exception, locale, key, options|
    raise "Missing translation: #{key}"
  end
end
