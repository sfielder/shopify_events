class Address
  include Mongoid::Document
  field :address1, type: String
  field :address2, type: String
  field :city, type: String
  field :company, type: String
  field :country, type: String
  field :country_code, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :name, type: String
  field :phone, type: String
  field :province, type: String
  field :province_code, type: String
  field :zip, type: String
  
  belongs_to :addressable, polymorphic: true
  
end
