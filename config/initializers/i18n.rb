# frozen_string_literal: true
# config/initializers/i18n.rb
if Rails.env.development? || Rails.env.test?
  I18n.exception_handler = lambda do |_exception, _locale, key, _options|
    raise "Missing translation: #{key}"
  end
end
