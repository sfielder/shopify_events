class WebhookEventsController < ApplicationController
  
  #before_filter :verify_webhook, :except => 'verify_webhook'
  
  # GET /webhook_events
  # GET /webhook_events.json
  def index
    @webhook_events = WebhookEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @webhook_events }
    end
  end

  # GET /webhook_events/1
  # GET /webhook_events/1.json
  def show
    @webhook_event = WebhookEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @webhook_event }
    end
  end

  # GET /webhook_events/new
  # GET /webhook_events/new.json
  def new
    @webhook_event = WebhookEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @webhook_event }
    end
  end


  # GET /webhook_events/1/edit
  def edit
    @webhook_event = WebhookEvent.find(params[:id])
  end

  # POST /webhook_events
  # POST /webhook_events.json
  def create
    
    puts "%%%%%%%%%%%% parameters #{params}"
    
    @webhook_event = WebhookEvent.new(
        shop: Shop.find(params["shopid"]),
        processed: false,
        body: params
      )

    respond_to do |format|
      if @webhook_event.save
        format.html { redirect_to @webhook_event, notice: 'Webhook event was successfully created.' }
        format.json { render json: @webhook_event, status: :created, location: @webhook_event }
      else
        format.html { render action: "new" }
        format.json { render json: @webhook_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /webhook_events/1
  # PUT /webhook_events/1.json
  def update
    @webhook_event = WebhookEvent.find(params[:id])

    respond_to do |format|
      if @webhook_event.update_attributes(params[:webhook_event])
        format.html { redirect_to @webhook_event, notice: 'Webhook event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @webhook_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webhook_events/1
  # DELETE /webhook_events/1.json
  def destroy
    @webhook_event = WebhookEvent.find(params[:id])
    @webhook_event.destroy

    respond_to do |format|
      format.html { redirect_to webhook_events_url }
      format.json { head :no_content }
    end
  end
 
  
  
  
  private
  
  def verify_webhook
    data = request.body.read.to_s
    hmac_header = request.headers['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, ShopifyEvents::Application.config.shopify.secret, data)).strip
    unless calculated_hmac == hmac_header
      head :unauthorized
    end
    request.body.rewind
  end
  
  
  
  
  
  
end
