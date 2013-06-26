class TicketType
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :name, type: String
  field :capacity, type: Integer
  field :price, type: Float
  field :shopify_product_variant_id, type: String
  
  belongs_to :account
  belongs_to :event
  tenant(:account)
  
  before_save :create_shopify_product_variant
  before_update :update_shopify_product_variant
  
  private
  
  def create_shopify_product_variant
    if self.shopify_product_variant_id.nil?
      self.shopify_product_variant_id = ShopifyAPI::Variant.create(
        :inventory_management => 'shopify', 
        :inventory_policy => 'deny',
        :inventory_quantity => self.capacity, 
        :option1 => self.name,
        :price => self.price,
        :sku => self.id,
        :product_id => self.event.shopify_product_id, 
        :title => self.name).id
    end
    
  end
  
  def update_shopify_product_variant
    if self.changed?
        variant = ShopifyAPI::Variant.find(self.shopify_product_variant_id)
        variant.price = self.price
        variant.inventory_quantity = self.capacity
        variant.title = self.name
        variant.save
    end
  end
  
end
