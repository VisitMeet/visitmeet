# frozen_string_literal: true
# app/controllers/application_controller.rb
# test: spec/controllers/application_controller_spec.rb
class ApplicationController < ActionController::Base
  # Set the language.
  before_action :set_locale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Internationalization reference
  # http://guides.rubyonrails.org/i18n.html
  # three methods available
  def set_locale
    # LOCAL PARAMS usage
    I18n.locale = params[:locale] || I18n.default_locale
    # # #
    # # TOP-LEVEL DOMAIN NAME usage : See 2.4 Setting the Locale from the Domain Name
    # #  : needs to be studied
    # #
    # # "do we want www.example.com to load the English (or default) locale,
    # # and www.example.es to load the Spanish locale. Thus the top-level domain name
    # # is used for locale setting. This has several advantages:
    # #
    # # The locale is an obvious part of the URL.
    # # People intuitively grasp in which language the content will be displayed.
    # # It is very trivial to implement in Rails.
    # # Search engines seem to like that content in different languages lives at different,
    # # inter-linked domains."
    # #
    # # SUBDOMAIN usage
    # # Get locale code from request SUBDOMAIN (like http://it.application.local:3000)
    # # You have to put something like:
    # #   127.0.0.1 gr.application.local
    # # in your /etc/hosts file to try this out locally
    # #
    # # def extract_locale_from_subdomain
    # #   parsed_locale = request.subdomains.first
    # #  I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    # # end
    # #
    # # Usage:
    # # link_to("Deutsch", "#{APP_CONFIG[:deutsch_website_url]}#{request.env['REQUEST_URI']}")
    # #
    # # assuming you would set APP_CONFIG[:deutsch_website_url] to some value
    # # like http://www.application.de
    # # #
    # #
    # # Final and possibly best solution is here : 2.5 Setting the Locale from the URL Params
    # #
    # TODO: 20160409 : Decision to make:
    # Please see : http://guides.rubyonrails.org/i18n.html
    # Specifically : 2.5 Setting the Locale from the URL Params, which makes use of the
    # url_for method wherever needed.
    # http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Base.html#method-i-default_url_options
  end
end
