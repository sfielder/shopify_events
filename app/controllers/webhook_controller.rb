class WebhookController < ApplicationController

  before_filter :verify_webhook, :except => 'verify_webhook'

  
  ############################# APP
  def app_uninstalled
    #puts "###################################### #{ShopifyAPI::Webhook.create(:address => "http://shopify-events.herokuapp.com/webhooks/events/update", :format => 'json', :topic => 'products/update').to_yaml}"
    #ShopifyAPI::Webhook.delete("3079807")
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "app_uninstalled %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
    
  end
  
  
  ############################# SHOP
  def shop_update
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "shop_update %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
  end
  
  
  ############################# ORDERS
  def orders_create
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "orders_create %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
  end
  
  
  def orders_updated
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "orders_updated %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
  end
  
  def orders_partially_fulfilled
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "orders_partially_fulfilled %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
  end
  
  def orders_paid
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "orders_paid %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
  end
  
  
  def orders_cancelled
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "orders_cancelled %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
  end
  
  
  def orders_fulfilled
  data = ActiveSupport::JSON.decode(request.body.read)
    puts "orders_fulfilled %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
  end
  
  
  
  ############################# PRODUCTS
  def products_updated #product_updated
    data = ActiveSupport::JSON.decode(request.body.read)
    puts "products_updated %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
    event = Event.where(:shopify_product_id => data["product_id"]).first
    puts "products_updated %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% event = " + event.to_yaml
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
    puts "products_deleted %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% data = " + data.to_s
    product = Product.where('shopify_id = ?', data["product_id"]).first
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