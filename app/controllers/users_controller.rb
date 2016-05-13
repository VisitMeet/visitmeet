# frozen_string_literal: true
# == Schema Information
# code: app/controllers/users_controller.rb
# test: spec/controllers/users_controller_spec.rb
#
# These are Functional Tests for Rail Controllers testing the
# various actions of a single controller. Controllers handle the
# incoming web requests to your application and eventually respond
# with a rendered view.
#
# See FAILING TESTS NOTE at line 62
#
# SECURITY UPGRADE NOTE:
# REFERENCE: http://edgeguides.rubyonrails.org/4_1_release_notes.html
#
# 2.8 CSRF protection from remote <script> tags
#
# Cross-site request forgery (CSRF) protection now covers
# GET requests with JavaScript responses, too. That prevents
# a third-party site from referencing your JavaScript URL
# and attempting to run it to extract sensitive data.
#
# This means any of your tests that hit .js URLs will now
# fail CSRF protection unless they use xhr. Upgrade your tests
# to be explicit about expecting XmlHttpRequests. Instead of
# `post :create, format: :js`, switch to the explicit
# `xhr :post, :create, format: :js`
#
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  provider               :string
#  uid                    :string
#
# FAILING TESTS NOTE:
# EXPLANATION: What is a 302 ?
# NOTE: DO NOT CHANGE THE REST METHOD ON A REDIRECT
# http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
# 10.3.3 302 Found
# The requested resource resides temporarily under a different URI.
# Since the redirection might be altered on occasion, the client
# SHOULD continue to use the Request-URI for future requests.
# This response is only cacheable if indicated by a Cache-Control or
# Expires header field. The temporary URI SHOULD be given by the
# Location field in the response. Unless the request method was HEAD,
# the entity of the response SHOULD contain a short hypertext note
# with a hyperlink to the new URI(s).
#
# If the 302 status code is received in response to a request other than GET or HEAD,
# # the user agent MUST NOT automatically redirect the request unless it can be
# # confirmed by the user, since this might change the conditions under which the
# # request was issued.
# #
# # Note: RFC 1945 and RFC 2068 specify that the client is not allowed
# #      to change the method on the redirected request.  However, most
# #      existing user agent implementations treat 302 as if it were a 303
# #      response, performing a GET on the Location field-value regardless
# #      of the original request method. The status codes 303 and 307 have
# #      been added for servers that wish to make unambiguously clear which
# #      kind of reaction is expected of the client.
# ==========================================================================================
#
# \/ === 302 result =============================================================================
# ./spec/controllers/products_controller_spec.rb, for example
# ./spec/controllers/users_controller_spec.rb, for example
#
# EXAMPLE:
#
#  4) ProductsController GET index has a 302 status code
#     Failure/Error: get :index
#
#     NoMethodError:
#       undefined method `authenticate!' for nil:NilClass
#
# https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)
# Authenticated routes in Rails 3
#
# If you choose to authenticate in routes.rb,
# # you lose the ability to test your routes via
# #  assert_routing (which combines
# #   assert_recognizes and
# #    assert_generates, so you lose them also).
#
# It's a limitation in Rails: Rack runs first and checks your routing information
# # but since functional/controller tests run at the controller level,
# #  you cannot provide authentication information to Rack which means
# #   request.env['warden'] is nil and Devise generates one of the following errors:
#
# NoMethodError: undefined method 'authenticate!' for nil:NilClass
# NoMethodError: undefined method 'authenticate?' for nil:NilClass
#
# The SOLUTION is to test authenticated routes in the controller tests.
# # To do this, stub out your authentication methods for the controller test,
# #  as described here: How-To: Stub authentication in controller specs.
# TODO: this still needs to be done to resolve the remaining failing tests
# # that are failing with the NoMethodError described above : 20160504 - ko
#
class UsersController < ApplicationController
  include ActionController::Helpers
  before_action :authenticate_user!, only: [:profile]
  respond_to :json, :html

  def profile
    @user = current_user
    @userscount = User.all.size
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      respond_with current_user, notice: 'User updated.'
    else
      redirect_to users_path, alert: 'Unable to update user.'
    end
    #
    # untested as yet : 20160508 -ko
    # if current_user.update(user_params[:user])
    #   redirect_to users_path, notice: 'User updated.'
    # else
    #   redirect_to users_path, alert: 'Unable to update user.'
    # end
  end

  def edit
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permi?t(:name, :bio)
    # params.require(:user).permit(:name, :email) # can be removed
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :provider, :uid, :bio)
  end
end
