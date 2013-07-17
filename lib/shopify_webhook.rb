class ShopifyWebhook 

 def self.verify_webhooks
    ShopifyAPI::Webhook.count
 end
 
 def self.get_webhooks
    ShopifyAPI::Webhook.find(:all)
 end


 def self.create_webhooks 
    Webhook.each do |wh|
      ShopifyAPI::Webhook.create(:address => "http://shopify-events.herokuapp.com/webhooks/#{wh.address}/#{Mongoid::Multitenancy.current_tenant.id}", :format => "#{wh.format}", :topic => "#{wh.topic}")
      #ShopifyAPI::Webhook.delete("3079807")
    end
 end








end
