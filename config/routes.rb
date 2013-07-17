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
  
  match 'webhooks/app/uninstalled/:id' => 'webhook#app_uninstalled'
  
  match 'webhooks/shop/updated/:id' => 'webhook#shop_updated'
  
  match 'webhooks/orders/partially_fulfilled/:id' => 'webhook#orders_partially_fulfulled'
  match 'webhooks/orders/fulfilled/:id' => 'webhook#orders_fulfulled'
  match 'webhooks/orders/cancelled/:id' => 'webhook#orders_cancelled'
  match 'webhooks/orders/paid/:id' => 'webhook#orders_paid'
  match 'webhooks/orders/updated/:id' => 'webhook#orders_updated'
  match 'webhooks/orders/delete/:id' => 'webhook#orders_delete'
  match 'webhooks/orders/create/:id' => 'webhook#orders_create'
  
  match "webhooks/products/update/:id", :to => "webhook#products_updated", :as => "webhooks_product_update"
  match 'webhooks/products/delete/:id' => 'webhook#products_delete'
  
  
  root :to => 'home#index'
  

end
