  class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_current_tenant
  
  
  def set_current_tenant
    if !session[:shopify].nil?
      current_shop = Shop.find_or_create_by(shopify_url: session[:shopify].url) 
      Mongoid::Multitenancy.current_tenant = current_shop
    end
  end
end
