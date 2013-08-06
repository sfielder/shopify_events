class Webhook
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  
  
  field :address, type: String
  field :format, type: String
  field :topic, type: String
end
