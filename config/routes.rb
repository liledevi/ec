Rails.application.routes.draw do
  root "products#index"
  resources :products, only: %i(show)
  namespace :admins do
    root "dashboards#index"
    get 'all', to: 'dashboards#all'
    get 'month', to: 'dashboards#month'
    resources :products, only: %i(new create)
  end
  
  resources :users
  resources :admins
    
  get 'sessions/new'
  post 'sessions/create'
  delete 'sessions/destroy'
  get 'sessions/new_admin'
  post 'sessions/create_admin'
  delete 'sessions/destroy_admin'
  
  get 'carts/show'
  post 'carts/create'
  delete 'carts/destroy'
  
  post 'charges/create'
end
