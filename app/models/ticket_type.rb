class TicketType
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :name, type: String
  field :capacity, type: Integer
  field :price, type: Float
  field :description, type: String
  
  belongs_to :account
  belongs_to :event
  tenant(:account)
  
  
end
