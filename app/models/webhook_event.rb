class WebhookEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :body, type: String
  field :shopify_store, type: String
  field :topic, type: String
  
  tenant(:shop)
end
