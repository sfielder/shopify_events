class WebhookEvent
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes
  include Mongoid::Multitenancy::Document
  include Mongoid::History::Trackable
  
  field :body, type: String
  field :processed, type: Boolean
  
  tenant(:shop)
  
  
  track_history   :on => :all,       # track title and body fields only, default is :all
                  #:modifier_field => :modifier, # adds "belongs_to :modifier" to track who made the change, default is :modifier
                  #:modifier_field_inverse_of => :nil, # adds an ":inverse_of" option to the "belongs_to :modifier" relation, default is not set
                  :version_field => :version,   # adds "field :version, :type => Integer" to track current version, default is :version
                  :track_create   =>  false,    # track document creation, default is false
                  :track_update   =>  true,     # track document updates, default is true
                  :track_destroy  =>  false    # track document destruction, default is false
  
  
  after_create :addToResque
  
  private
  def addToResque
    puts "WEBHOOK EVENT ADDTORESQUE"
    Resque.enqueue_in(2.minutes, ShopifyWebhookWorker, self.shop_id)
  end
  
  
  
end
