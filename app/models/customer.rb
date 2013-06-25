class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :phone, type: String
  field :address1, type: String
  field :address2, type: String
  field :province, type: String
  field :country, type: String
  field :state, type: String
  field :zip, type: String
  field :shopify_id, type: String
  field :accepts_marketing, type: Boolean
  
  belongs_to :account
  tenant(:account)
  
  has_many :registrations
  
end
