class WebhookController < ApplicationController
  
  before_filter :verify_webhook, :except => 'verify_webhook'
  
  ############################# APP
  def new_webhook
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% method  #{params["method"]}"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% class  #{params["class"]}"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% shopid  #{params["shopid"]}"  
    
    @wh = Event.new
    puts "################# #{@wh}"
    #@wh.class = params["class"]
    #@wh.method = params["method"]
    #@wh.shop = params["shopid"]
    #@wh.body = params
    #@wh.save!
    
    head :ok
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