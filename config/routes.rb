Rails.application.routes.draw do
  get 'users/profile'

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end


  resources :products

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
              controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  # root to: 'visitors#index'
  root to: 'welcome#index'
end
