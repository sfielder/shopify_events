class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :title, type: String
  field :start_datetime, type: String
  field :end_datetime, type: String
  field :venue_street_address, type: String
  field :venue_secondary_address, type: String
  field :venue_city, type: String
  field :venue_state_province, type: String
  field :venue_country, type: String
  field :venue_virtual, type: Boolean
  
  belongs_to :account
  tenant(:account)
  
  
end
