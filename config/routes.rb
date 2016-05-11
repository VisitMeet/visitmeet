# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routings : assigned kathyonu : 20160416
Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # ALL GET REQUESTS HERE
  get 'profile/index'
  get 'users/profile'
  get 'visitors/index'
  get 'visitors/team'

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  # ALL RESOURCE ROUTES HERE
  resources :shopping_carts
  resources :users
  resources :products
  resources :conversations do
    resources :messages
  end

  root to: 'welcome#index'
end
