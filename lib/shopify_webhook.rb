class ShopifyWebhook 



 def self.verify_webhooks
    
    ShopifyAPI::Webhook.count
    
 end


 def self.create_webhooks
  
    Webhook.all.each do |wh|
      ShopifyAPI::Webhook.create(:address => "http://shopify-events.herokuapp.com/webhooks/#{wh.address}", :format => "#{wh.format}", :topic => "#{wh.topic}")
      #ShopifyAPI::Webhook.delete("3079807")
    end
 end








end
