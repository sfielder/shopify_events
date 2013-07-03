class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    # get 5 products
    #@products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
    
    # get latest 5 orders
    #@orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
    @orders   = Order.all.limit(5).order_by(:created_at.asc)
    
    #puts "###################################### #{ShopifyAPI::Webhook.create(:address => "http://shopify-events.herokuapp.com/#{session[:shopify].url}/events/update", :format => 'json', :topic => 'products/update').to_yaml}"
    #ShopifyAPI::Webhook.delete("3079737")
    puts "ACTIVE WEBHOOKS ###################################### #{ShopifyAPI::Webhook.find(:all).to_yaml}"
    
    
  end
  
end