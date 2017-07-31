Rails.application.routes.draw do
  
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'breathe#index'
  
  post '/city_data' => 'cities#city_data'
  get '/cached_city_data' => 'cities#cached_city_data'
  get '/city_data_back' => 'cities#city_data_back'

  get '/favorite_city' => 'cities#favorite_city'
  get '/display_favorite_cities' => 'cities#display_favorite_cities'
  
  get 'auth/:provider/callback', to: "sessions#create"

  get 'authentication_test/:name' => "sessions#create", as: 'auth_test'

  get 'auth/failure', to: redirect('/')

  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  
  get 'authcheck' => "sessions#checklogged"


  post '/markers' => 'markers#create'
  get '/markers' => 'markers#show'
  delete '/markers' => 'markers#delete'
  put '/markers' => 'markers#edit'
  
  resources :cities, :clients
  
  
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
