Rails.application.routes.draw do
  #  get 'sessions/new'

  #  get 'homepage/index'

  root to: 'home#index'
  get 'sign_in' => 'authentication#sign_in'
  post 'sign_in' => 'authentication#login'
  get 'signed_out' => 'authentication#signed_out'
  get 'new_user' => 'authentication#new_user'
  post 'new_user' => 'authentication#register'
  get 'account_settings' => 'authentication#account_settings'
  put 'account_settings' => 'authentication#set_account_info'
  get 'places/:id' => 'home#show_place', as: :place
  post 'places/:id' => 'home#add_tag'
  delete 'places/delete/:id' => 'home#delete', as: :place_delete
  get 'places/comment/:id' => 'home#new_comment', as: :place_comments
  post 'places/comment/:id' => 'home#add_comment'
  get 'places/add/new' => 'home#new_place', as: :new_place
  post 'places/add/new' => 'home#add_place'
  get 'places/edit/:id' => 'home#edit_place', as: :place_edit
  put 'places/edit/:id' => 'home#change_place'
  get 'users/:id' => 'users#get', as: :user_getter
  get 'users' => 'users#fetcher', as: :user

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
