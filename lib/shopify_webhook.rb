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
      #ShopifyAPI::Webhook.delete("3079807")
    end
 end

  
 
 def self.process_order webhook_event
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "data = " + data.to_s
    product = Product.where('shopify_id = ?', data["id"]).first
    if product
      event = WebhookEvent.new(:event_type => "product update")
      event.save
      product.name = data["title"]
      product.webhook_events << event
      product.save
    end
 end 

 def self.process_product webhook_event
  
 end
  
 def self.process_shop webhook_event
  
 end
 
 def self.process_app webhook_event
  
 end 




end
