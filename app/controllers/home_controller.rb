class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
    
  
    
  end
  
  def index
     
    # get latest 5 orders
    @orders   = Order.all.limit(5).order_by(:created_at.asc)
    
    @count = ShopifyWebhook.verify_webhooks 
    
    @webhooks = ShopifyWebhook.get_webhooks
=begin    
    if ShopifyWebhook.verify_webhooks == Webhook.count
    
     else
         ShopifyWebhook.create_webhooks
     end
=end        
    
    
   end
  
end