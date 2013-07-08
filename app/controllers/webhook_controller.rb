class WebhookController < ApplicationController

  before_filter :verify_webhook, :except => 'verify_webhook'

  
  ############################# APP
  def app_uninstalled
    #puts "###################################### #{ShopifyAPI::Webhook.create(:address => "http://shopify-events.herokuapp.com/webhooks/events/update", :format => 'json', :topic => 'products/update').to_yaml}"
    #ShopifyAPI::Webhook.delete("3079807")
    
  end
  
  
  ############################# SHOP
  def shop_update
  
  end
  
  
  ############################# ORDERS
  def orders_create
  
  end
  
  
  def orders_updated
  
  end
  
  def orders_partially_fulfilled
  
  end
  
  def orders_paid
  
  end
  
  
  def orders_cancelled
  
  end
  
  
  def orders_fulfilled
  
  end
  
  
  
  ############################# PRODUCTS
  def products_updated #product_updated
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
    event = Event.where(:shopify_product_id => data["id"]).first
    if event
      whevent = WebhookEvent.new(:event_type => "event update")
      whevent.save
      event.title = data["title"]
      event.webhook_events << whevent
      event.save
    end
      head :ok
  end

  def products_deleted
    data = ActiveSupport::JSON.decode(request.body.read)
    product = Product.where('shopify_id = ?', data["id"]).first
    if product
      puts 'products shop id: ' + product.shop.id
      event = WebhookEvent.new(:event_type => "product delete")
      event.save
      product.logical_delete = true
      product.webhook_events << event
      product.shop.webhook_events << event
      product.shop.save
      product.save
    end
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