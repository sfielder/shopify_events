class Shop
  include Mongoid::Document
  field :shopify_url, type: String
  field :name, type: String
  
  private 
  
  def create_webhooks 
    ShopifyWebhook.create_webhooks
  end
  
  
end
