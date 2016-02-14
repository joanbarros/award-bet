Rails.application.routes.draw do
  get 'category/index'

  devise_for :users
  get 'login/index'

  get 'mybets/index'

  get 'awards/index'

  get 'dashboard/index'

  get 'categories/index'

  get '/configuration', to: 'configuration#index'

  get '/mybets', to: 'mybets#index'


  get '/mybets/refresh', to: 'mybets#refresh'

  get "login", to: 'login#index'

  get "/dashboard", to: 'dashboard#index'

  get "/categories", to: "categories#index"




resources :awards


#this could be improved on the future...
resources :categories do
  member do

    get 'new_nominee'
    put 'edit_nominee'
    put 'update_nominee'
    patch 'edit_nominee'
    delete 'destroy_nominee'
    post 'create_nominee'

    get 'new_bet'
    put 'edit_bet'
    patch 'edit_bet'
    put 'update_bet'
    patch 'update_bet'
    delete 'destroy_bet'
    post 'create_bet'


  end
end










  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'awards#index'

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
