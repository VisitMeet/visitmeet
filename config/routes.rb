# frozen_string_literal: true
# code: config/routes.rb
# test: spec/routing/admin/application_controller_routing_spec.rb
# test: spec/routing/admin/categories_controller_routing_spec.rb
# test: spec/routing/admin/products_controller_routing_spec.rb
# test: spec/routing/admin/users_controller_routing_spec.rb
# test: spec/routing/user/omniauth_callback_controller_routing_spec.rb
# test: spec/routing/products_routing_spec.rb
# test: spec/routing/users_routing_spec.rb
# test: spec/routing/visitors_routing_spec.rb
#
Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # ALL GET REQUESTS HERE
  get 'profile/index'
  get 'users/profile'
  get 'visitors/index'
  get 'visitors/team'
  get 'pages/about' => 'high_voltage/pages#show', id: 'about'
  # get '/about' => 'high_voltage/pages#show', id: 'about'

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  # ALL RESOURCE ROUTES HERE
  resources :shopping_cart
  resources :products
  resources :conversations do
    resources :messages
  end

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
