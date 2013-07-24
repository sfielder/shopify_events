class WebhookEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :body, type: String
  field :processed, type: Boolean
  
  belongs_to :shop
  tenant(:shop)
  
  
  
end
