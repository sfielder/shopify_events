class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :shopify_id, type: String
  
  belongs_to :account
  tenant(:account)
  
  has_many :registrations
  
  
  
  
  
  
  
  
  
end
