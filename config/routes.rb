Rails.application.routes.draw do

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
  resource :shopping_cart
  resources :products
  resources :conversations do
    resources :messages
  end

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'welcome#index'

end
