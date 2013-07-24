ShopifyEvents::Application.routes.draw do
  

  resources :histories


  resources :webhook_events


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
  
  resources :webhook_events
  
  #webhooks
  match ":class/:method/:shopid/webhook.json", :to => "webhook_events#create"
  
  root :to => 'home#index'
  

end
