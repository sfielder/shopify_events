class LineItem
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  include Mongoid::Versioning
  
  belongs_to :shop
  belongs_to :order
  tenant(:shop)
  
  field :fulfillment_service, type: String
  field :fulfillment_status, type: String
  field :shopify_id, type: String
  field :product_id, type: String
  field :quantity, type: Integer
  field :requires_shipping, type: Boolean
  field :sku, type: String
  field :title, type: String
  field :variant_id, type: String
  field :variant_title, type: String
  field :vendor, type: String
  field :name, type: String
  field :variant_inventory_management, type: String
  field :properties, type: String
  field :product_exists, type: Boolean
  
  
  
  
  
end
