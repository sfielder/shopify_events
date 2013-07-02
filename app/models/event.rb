class Event
  
  require 'chronic'
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  
  field :title, type: String
  field :start_datetime, type: String
  field :starttime, type: Time
  field :end_datetime, type: String
  field :endtime, type: Time
  field :venue_street_address, type: String
  field :venue_secondary_address, type: String
  field :venue_city, type: String
  field :venue_state_province, type: String
  field :venue_country, type: String
  field :venue_virtual, type: Boolean
  field :shopify_product_id, type: String
  field :body_html, type: String 
  
  belongs_to :account
  tenant(:account)
  
  has_many :variants
  has_many :orders
  has_many :attendees
  
  scope :upcoming, where(:starttime.gte => Time.now) 
  scope :previous, where(:starttime.lte => Time.now) 
  
  before_save :setdates
  before_save :create_shopify_product
  before_update :update_shopify_product
  
  private
  
  def setdates
    
  end
  
  
  def create_shopify_product
    if self.shopify_product_id.nil?
        self.shopify_product_id = ShopifyAPI::Product.create(
              :product_type => "Event",
              :vendor => "Shopify EVENTS", 
              :title => self.title).id
    end
    
  end
  
  def update_shopify_product
    if self.changed?
        product = ShopifyAPI::Product.find(self.shopify_product_id)
        product.title = self.title
        product.body_html = self.body_html
        product.save
    end
    
  end
  
  
  
  
  
end
