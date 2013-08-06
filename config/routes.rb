ShopifyEvents::Application.routes.draw do
  

  devise_for :users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Resque::Server, :at => "/resque"
  
  
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
  match ":class/:method/:shopid/webhook.json", :to => "webhook_events#create"
  
  root :to => 'home#index'
  

end
