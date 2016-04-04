# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Set the language.
  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
