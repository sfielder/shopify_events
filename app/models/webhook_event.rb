class WebhookEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :method, type: String
  field :class, type: String
  field :body, type: String
  
  belongs_to :shop
  
  
end
