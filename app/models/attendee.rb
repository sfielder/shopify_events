class Attendee
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  include Mongoid::History::Trackable
  
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :phone, type: String
  field :address1, type: String
  field :address2, type: String
  field :province, type: String
  field :country, type: String
  field :zip, type: String
  
  
  belongs_to :order
  belongs_to :product
  
  tenant(:shop)
  
end
