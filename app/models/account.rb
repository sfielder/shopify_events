class Account
  include Mongoid::Document
  field :shopify_url, type: String
end
