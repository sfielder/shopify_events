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
    
    #puts "###################################### #{ShopifyAPI::Webhook.create(:address => "http://postcatcher.in/catchers/51d084f5249f160200001195", :format => 'json', :topic => 'app/uninstalled').to_yaml}"
    puts "###################################### #{ShopifyAPI::Webhook.find(:all).to_yaml}"
    
    
  end
  
end