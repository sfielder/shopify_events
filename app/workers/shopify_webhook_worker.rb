class ShopifyWebhookWorker < Resque::JobWithStatus
  extend HerokuResqueAutoScale if Rails.env.production? # only extend in production
  
 
  
  def self.perform(worker_id, webhookevent_id)
    
    puts "WORKER_ID: #{worker_id}"
    puts "INTEGRATION_ID: #{webhookevent_id}"
    
    
    
    
=begin   
   client = SalesforceClient.create(integration_id)
   puts "@ CLIENT IN SALESFORCE WORKER ----------------- #{client.to_yaml}"
   
   @m2m_connection = AppConnection.find(Integration.find(integration_id).m2m_platform)
   puts "@ @m2m_connection ----------------- #{@m2m_connection.to_yaml}"
    
  AirvantageSalesforceMethods.upsert_systems_dataitems(client, Airvantage.parse_systems_response(Airvantage.get_systems(@m2m_connection.token), integration_id))
  AirvantageSalesforceMethods.upsert_alerts_dataitems(client,Airvantage.parse_alerts_response(Airvantage.get_alerts(@m2m_connection.token), integration_id))
=end   
  return true 
    
  end
  
end