class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
    
  end
  
  def index
     
     @history = Product.all.first.history_tracks
     
    # get latest 5 orders
    @orders   = Order.all.limit(5).order_by(:created_at.asc)
    
    end
  
end