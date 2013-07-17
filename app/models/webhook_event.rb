class WebhookEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :body, type: String
  field :class, type: String
  field :method, type: String
  
  belongs_to :shop
  tenant(:shop)
end
