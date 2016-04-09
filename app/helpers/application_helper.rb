# frozen_string_literal: true
# app/controllers/application_controller.rb
# SECURITY UPGRADE NOTE:
# REFERENCE: http://edgeguides.rubyonrails.org/4_1_release_notes.html
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
module ApplicationHelper
end
