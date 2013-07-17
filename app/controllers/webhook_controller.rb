class WebhookController < ApplicationController
  
  before_filter :verify_webhook, :except => 'verify_webhook'
  
  ############################# APP
  def new
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% method  #{params["method"]}"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% class  #{params["class"]}"
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% shopid  #{params["shopid"]}"  
    
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
    
    wh = Webhook.new(:class => params["class"], :method => params["method"], :shop => params["shopid"], :body => data)
    wh.save!
    
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