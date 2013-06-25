class TicketType
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :name, type: String
  field :capacity, type: Integer
  field :price, type: Float
  field :description, type: String
  field :shopify_product_variant_id, type: String
  field :shopify_inventory_management, type: String # "shopify" default value to enforce
  field :shopify_inventory_policy, type: String # "deny" default value to enforce max limits
  
  belongs_to :account
  belongs_to :event
  tenant(:account)
  
  
end
