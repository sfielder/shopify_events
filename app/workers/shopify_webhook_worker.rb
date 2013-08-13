class ShopifyWebhookWorker < Resque::JobWithStatus
  extend HerokuResqueAutoScale if Rails.env.production? # only extend in production
  
 
  
  def self.perform(worker_id, webhookevent_id)
    
    puts "WORKER_ID: #{worker_id}"
    puts "INTEGRATION_ID: #{webhookevent_id}"
    
    ShopifyWebhook.process_webhook_event(WebhookEvent.find(webhookevent_id))
    
   return true 
    
  end
  
end