class ShopifyWebhook 

 def self.verify_webhooks
    ShopifyAPI::Webhook.count
 end
 
 def self.get_webhooks
    ShopifyAPI::Webhook.find(:all)
 end


 def self.create_webhooks 
    Webhook.each do |wh|
      ShopifyAPI::Webhook.create(:address => "#{request.protocol}#{request.host}/#{wh.address}/#{Mongoid::Multitenancy.current_tenant.id}/webhook.json", :format => "#{wh.format}", :topic => "#{wh.topic}")
  end
 end
 
 def self.process_webhook_event webhook_event
    data = ActiveSupport::JSON.decode(webhook_event.body)
    puts "data = " + data.to_s
    
    @class = data["class"].classify.constantize 
            
    puts "########################### @class #{@class}"
    puts "########################### data[method] #{data["method"]}"
      
    if params["method"] == "create" 
      
        #ONLY RETURN THE LINE ITEMS THAT HAVE PRODUCTS
        #EXISTING IN SHOPIFY EVENTS
        @lineitems = Array.new
        @order = Order.new
        
        params["line_items"].each do |s|
          if Product.find(s["product_id"])
             puts "########################### PRODUCT IS A MATCH"
          end
        end
        
        
        
    else
      
      @instance = @class.where(shopify_id: params["id"])
      
      if !@instance.nil?
        
        @instance.update()  
        
      end
      
    end 
=begin       
      update
      delete
      
      partially_fulfilled
      paid
      fulfilled
      delete
      create
      cancelled
      
      uninstalled
=end      
  
 end
  
 




end
