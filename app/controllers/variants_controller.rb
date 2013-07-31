class VariantsController < ApplicationController
  
  around_filter :shopify_session
  
  # GET /ticket_types
  # GET /ticket_types.json
  def index
    @variants = Variant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @variants }
    end
  end

  # GET /ticket_types/1
  # GET /ticket_types/1.json
  def show
    @variant = Variant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @variant }
    end
  end

  # GET /ticket_types/new
  # GET /ticket_types/new.json
  def new
    @variant = Variant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @variant }
    end
  end

  # GET /ticket_types/1/edit
  def edit
    @variant = Variant.find(params[:id])
  end

  # POST /ticket_types
  # POST /ticket_types.json
  def create
    
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ PARAMS: #{params}"
    @variant = Variant.new(params[:variant])

    respond_to do |format|
      if @variant.save
        format.html { redirect_to event_path(@variant.product), notice: 'Ticket type was successfully created.' }
        format.json { render json: @variant, status: :created, location: @variant }
      else
        format.html { render action: "new" }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_types/1
  # PUT /ticket_types/1.json
  def update
    @variant = Variant.find(params[:id])

    respond_to do |format|
      if @variant.update_attributes(params[:variant])
        format.html { redirect_to event_path(@variant.event), notice: 'Ticket type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_types/1
  # DELETE /ticket_types/1.json
  def destroy
    @variant = Variant.find(params[:id])
    
    @event = @variant.event
    
    #@variant.destroy
    @variant.deactivate_shopify_product_variant
    @variant.active = false
    @variant.save

    respond_to do |format|
      format.html { redirect_to event_path(@variant.event), notice: 'Ticket type was successfully deactivated.' }
      format.json { head :no_content }
    end
  end
end
