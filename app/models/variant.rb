class Variant
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  include Mongoid::Versioning
  
  field :name, type: String
  field :capacity, type: Integer
  field :price, type: Float
  field :shopify_id, type: String
  field :shopify_product_id, type: String
  field :active, type: Boolean
  field :barcode, type: String
  field :compare_at_price, type: String
  field :fulfillment_service, type: String
  field :grams, type: String
  field :inventory_management, type: String
  field :inventory_policy, type: String
  field :option1, type: String
  field :option2, type: String
  field :option3, type: String
  field :position, type: String
  field :requires_shipping, type: Boolean
  field :sku, type: String
  field :taxable, type: Boolean
  field :title, type: String
  field :inventory_quantity, type: Integer
  field :options, type: String
  field :images, type: String
  
  belongs_to :shop
  belongs_to :product
  tenant(:shop)
  
  before_save :create_shopify_product_variant
  before_update :update_shopify_product_variant
  
  def deactivate_shopify_product_variant
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ self.active #{self.active}"
    variant = ShopifyAPI::Variant.find(self.shopify_id)
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ variant #{variant}"
    variant.inventory_quantity = 0
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ VARIANT SAVE TO YAML #{variant.save}"
   end
  
  def create_shopify_product_variant
    if self.shopify_id.nil?
      puts "$$$$$$$$$$$$$$$$$$$$$$$$ #{self.product_id}"
      product = Product.find(self.product_id)
    
      self.shopify_id = ShopifyAPI::Variant.create(
        :inventory_management => 'shopify', 
        :inventory_policy => 'deny',
        :inventory_quantity => self.capacity, 
        :option1 => self.name,
        :price => self.price,
        :sku => self.id,
        :product_id => product.shopify_id, 
        :title => self.name).id
       self.active = true 
    end
    
  end
  
  def update_shopify_product_variant
    if self.changed?
        variant = ShopifyAPI::Variant.find(self.shopify_id)
        variant.price = self.price
        variant.inventory_quantity = self.capacity
        variant.title = self.name
        variant.save
    end
  end
  
  
  
end
