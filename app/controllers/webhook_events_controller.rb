class WebhookEventsController < ApplicationController
  
  before_filter :verify_webhook, :except => 'verify_webhook'
  
  def create
    
    puts "%%%%%%%%%%%% parameters #{params}"
    
    #@models = ActiveRecord::Base.connection.tables.collect{|t| t.underscore.singularize.camelize}
    if Shop.find(params["shopid"])
      @class = params["class"].classify.constantize 
      @instance = @class.where(shopify_id: params["id"])
      
      puts "########################### @class #{@class}"
      puts "########################### @product #{@instance.to_json}"
      
      if !@instance.nil?
         @webhook_event = WebhookEvent.new(
          shop: Shop.find(params["shopid"]),
          processed: false,
          body: params
        )
        
      end
    end
    
    respond_to do |format|
      if @webhook_event.save
        #format.html { redirect_to @webhook_event, notice: 'Webhook event was successfully created.' }
        format.json { render json: @webhook_event, status: :created }
      else
        #format.html { render action: "new" }
        format.json { render json: @webhook_event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  private
  
  def verify_webhook
    data = request.body.read.to_s
    hmac_header = request.headers['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, ShopifyEvents::Application.config.shopify.secret, data)).strip
    unless calculated_hmac == hmac_header
      head :unauthorized
    end
    request.body.rewind
  end
  
  
  
  
  
  
end
