class Product
  
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
  field :shopify_id, type: String
  field :body_html, type: String 
  field :handle, type: String
  field :product_type, type: String
  field :published_scope, type: String
  field :vendor, type: String
  field :tags, type: String
  
  
  belongs_to :shop
  tenant(:shop)
  
  embeds_many :variants
  accepts_nested_attributes_for :variants
  
  has_many :orders
  has_many :attendees
  has_many :webhook_events
  
  scope :upcoming, where(:starttime.gte => Time.now) 
  scope :previous, where(:starttime.lte => Time.now) 
  
  before_save :create_shopify_product
  before_update :update_shopify_product
  
  private
  
  def start_datetime
    if(starttime != nil)
      starttime.to_s(:pretty)
    else
      Time.now.to_s(:pretty)
    end
    
  end
  
  def start_datetime=(start_datetime)
    self.starttime = Chronic.parse(start_datetime)
  end
  
  def end_datetime
    if(endtime != nil)
      endtime.to_s(:pretty)
    else
      Time.now.to_s(:pretty)
    end
    
  end
  
  def end_datetime=(end_datetime)
    self.endtime = Chronic.parse(end_datetime)
  end
  
  
  def create_shopify_product
  
    if self.shopify_id.nil?
      self.shopify_id = ShopifyAPI::Product.create(
              :product_type => "Event",
              :vendor => "Shopify EVENTS", 
              :title => self.title).id
    end
    
  end
  
  def update_shopify_product
    if self.changed?
      
        if self.shopify_product_id.nil?
          create_shopify_product
        else 
          product = ShopifyAPI::Product.find(self.shopify_product_id)
          product.title = self.title
          product.body_html = self.body_html
          product.save
          
        end
      
        
    end
    
  end
  
  
  
  
  
end
