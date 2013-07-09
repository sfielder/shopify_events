class WebhookEvent
  include Mongoid::Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  belongs_to :account
  belongs_to :order
  belongs_to :variant
  belongs_to :event
  
  tenant(:account)
end
