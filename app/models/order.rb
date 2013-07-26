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
  field :buyer_accepts_marketing, type: Boolean
  field :cancel_reason, type: String
  field :cancelled_at, type: Time
  field :confirmed, type: Boolean
  field :currency, type: String
  field :email, type: String
  field :financial_status, type: String
  field :fulfillment_status, type: String
  field :gateway, type: String
  field :landing_site, type: String
  field :location_id, type: String
  field :name, type: String
  field :note, type: String
  field :number, type: String
  field :reference, type: String
  field :referring_site, type: String
  field :source, type: String
  field :subtotal_price, type: Float
  field :taxes_included, type: Boolean
  field :test, type: Boolean
  field :total_discount, type: Float
  field :total_line_items_price, type: Float
  field :total_price, type: Float
  field :total_price_usd, type: Float
  field :total_tax, type: Float
  field :total_weight, type: Float
  field :user_id, type: String
  field :discount_codes, type: String
  field :note_attributes, type: String
  field :processing_method, type: String
  field :checkout_id, type: String
  field :shipping_lines, type: String
  field :tax_lines, type: String
  field :billing_address, type: String
  field :shipping_address, type: String
  field :fulfillments, type: String
  field :customer, type: String
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  belongs_to :shop
  belongs_to :event
  belongs_to :customer
  tenant(:shop)
  
  has_one :address, :as => :billing_address
  
  has_many :attendees
  
end
