ShopifyEvents::Application.routes.draw do
  

  devise_for :users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  match 'welcome' => 'home#welcome'
  match 'design' => 'home#design'
  
  match 'logout' => 'sessions#destroy'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'auth/shopify/callback' => :show
    delete 'logout' => :destroy
  end
  
  resources :events, controller: 'products'
  resources :products
  resources :variants
  resources :customers
  resources :orders
  resources :attendees
  
  
  #webhooks
  match "webhooks/:class/:method/:shopid", :to => "webhook#new_webhook"
  
  root :to => 'home#index'
  

end
