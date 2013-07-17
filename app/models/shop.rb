class Shop

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  
  field :shopify_url, type: String
  field :name, type: String
  
  private 
  
  def create_webhooks 
    ShopifyWebhook.create_webhooks
  end
  
  
end
