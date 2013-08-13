class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
    
  end
  
  def index
     
    
    puts "&&&&&&&&&&&&&&& ShopifyWebhook.verify_webhooks #{ShopifyWebhook.verify_webhooks}"
    puts "&&&&&&&&&&&&&&& Webhook.all.count #{Webhook.all.count}"
     
    if ShopifyWebhook.verify_webhooks != Webhook.all.count #{request.protocol}#{request.host}
      
      Webhook.each do |wh|
        puts " WEBHOOK --------------- #{ShopifyAPI::Webhook.create(:address => "https://shopify-events.herokuapp.com/#{wh.address}/#{Mongoid::Multitenancy.current_tenant.id}/webhook.json", :format => "#{wh.format}", :topic => "#{wh.topic}").to_yaml}"
      end
    
    else
      
    end
    
    puts "************ ShopifyWebhook.verify_webhooks #{ShopifyWebhook.verify_webhooks} " 
    @webhookcount = ShopifyWebhook.verify_webhooks
    # get latest 5 orders
    @orders   = Order.all.limit(5).order_by(:created_at.asc)
    
    end
  
end