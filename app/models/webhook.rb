class Webhook
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::History::Trackable
  
  field :address, type: String
  field :format, type: String
  field :topic, type: String
end
