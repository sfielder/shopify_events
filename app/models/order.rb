class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :order_number, type: String
  field :quantity, type: Integer
  field :total, type: Float
  field :status, type: String
  field :shopify_id, type: String
  
  belongs_to :shop
  belongs_to :event
  belongs_to :customer
  tenant(:shop)
  
  has_one :address, :as => :billing_address
  
  has_many :attendees
  
end
