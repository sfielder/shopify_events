class Shop

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::History::Trackable
  
  field :shopify_url, type: String
  field :name, type: String
  field :address1, type: String
  field :city, type: String
  field :country, type: String
  field :customer_email, type: String
  field :domain, type: String
  field :email, type: String
  field :shopify_id, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :phone, type: String
  field :province, type: String
  field :public, type: String
  field :source, type: String
  field :zip, type: String
  field :country_code, type: String
  field :country_name, type: String 
  field :currency, type: String
  field :timezone, type: String
  field :shop_owner, type: String
  field :money_format, type: String
  field :money_with_currency_format, type: String
  field :province_code, type: String
  field :taxes_included, type: String
  field :tax_shipping, type: String
  field :plan_display_name, type: String
  field :plan_name, type: String
  field :myshopify_domain, type: String
  field :google_apps_domain, type: String
  field :google_apps_login_enabled, type:String
  field :money_in_emails_format, type: String
  field :money_with_currency_in_emails_format, type: String
  
  
  private 
  
  def create_webhooks 
    ShopifyWebhook.create_webhooks
  end
  
  
end
