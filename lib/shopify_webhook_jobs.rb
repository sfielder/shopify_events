class ShopifyWebhookJobs
  
  
  def self.enqueue_background_job 
    Resque.enqueue_in(2.minutes, ShopifyWebhookWorker, params[:webhookevent_id])
    return true
  end
  
  
=begin  
  #scheduled process manager
  def self.enqueue_scheduled_job 
    
    @integration = Integration.find(params[:id])
    
    classname = "#{AppConnection.find(@integration.m2m_platform).app.name}#{AppConnection.find(@integration.enterprise_platform).app.name}Worker"
    
    Resque.set_schedule("#{Account.find(@integration.account).name} - #{@integration.name} - #{@integration.id}", 
                                      {
                                       :class => classname,
                                       :cron => "0 * * * * *",
                                       :queue => "#{Account.find(@integration.account).name}",
                                       :args => @integration.id 
                                       }
                        )
     
     @integration.update_attributes!(:active => true)
                       
    redirect_to auth_integrations_path, notice: 'Job was successfully started.'
    
  end
  
  
  def self.remove_job
    @integration = Integration.find(params[:id])
   Resque.remove_schedule("#{Account.find(@integration.account).name} - #{@integration.name} - #{@integration.id}")
   @integration.update_attributes!(:active => false)
   redirect_to auth_integrations_path, notice: 'Job was successfully stopped.'
  end
=end  
  
  
  
  
  
  
  
end

