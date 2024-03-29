Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'root#routing'

  get 'products' => 'iron#products'
  get 'about' => 'iron#about'

  resources :users do
    resources :messages
    get '/conversation/:sender_id' => 'messages#conversation'

    # resources :restaurants
    # post 'restaurants/new' => 'restaurants#create'
  end
  get 'password_recovery' => 'users#password_recovery'
  post 'contact' => 'root#contact'

  get 'conversation/:your_id/:user_id' => 'messages#conversation'

  post '/resend_confirmation_email' => 'users#resend_confirmation_email'
  post '/deactivate_user' => 'users#deactivate_user'
  post '/activate_user' => 'users#activate_user'

  get "login" => "sessions#new", as: :login
  post "login" => "sessions#create"
  post "authenticate" => "sessions#authenticate"
  post "unique_email" => "users#unique_email"
  delete "logout" => "sessions#destroy", as: :logout

  get 'admin' => 'admin#home'
  get 'admin/analytics' => 'admin#analytics'
  get 'admin/users' => 'admin#users'

  get 'blogs' => 'blogs#index'
  get 'blog/:slug' => 'blogs#show'
  get 'article/:slug' => 'articles#show'

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
