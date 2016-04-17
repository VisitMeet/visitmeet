# frozen_string_literal: true
# code: app/controllers/users_controller.rb
# test: spec/controllers/users_controller_spec.rb
# These are Functional Tests for Rail Controllers testing the
# various actions of a single controller. Controllers handle the
# incoming web requests to your application and eventually respond
# with a rendered view.
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
# == Schema Information
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
class UsersController < ApplicationController
  include ActionController::Helpers

  before_action :authenticate_user!, only: [:profile]

  def profile
    @userscount = User.all.size
  end
end
