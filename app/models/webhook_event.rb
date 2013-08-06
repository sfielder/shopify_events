class WebhookEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  include Mongoid::Versioning
  
  field :body, type: String
  field :processed, type: Boolean
  
  belongs_to :shop
  tenant(:shop)
  
  
  
end
