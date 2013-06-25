class Registration
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :order_number, type: String
  field :quantity, type: Integer
  field :total, type: Float
  field :status, type: String
  
  belongs_to :account
  belongs_to :event
  belongs_to :customer
  tenant(:account)
  
  
  has_many :attendees
  
end
