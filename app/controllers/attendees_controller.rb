class AttendeesController < ApplicationController
  
  around_filter :shopify_session
  
  # GET /ticket_types
  # GET /ticket_types.json
  def index
    @attendees = Attendee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attendees }
    end
  end

  # GET /ticket_types/1
  # GET /ticket_types/1.json
  def show
    @attendee = Attendee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attendee }
    end
  end

  # GET /ticket_types/new
  # GET /ticket_types/new.json
  def new
    @attendee = Attendee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attendee }
    end
  end

  # GET /ticket_types/1/edit
  def edit
    @attendee = Attendee.find(params[:id])
  end

  # POST /ticket_types
  # POST /ticket_types.json
  def create
    
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ PARAMS: #{params}"
    @attendee = Attendee.new(params[:attendee])

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to event_path(@attendee.event), notice: 'Attendee was successfully created.' }
        format.json { render json: @attendee, status: :created, location: @attendee }
      else
        format.html { render action: "new" }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_types/1
  # PUT /ticket_types/1.json
  def update
    @attendee = Attendee.find(params[:id])

    respond_to do |format|
      if @attendee.update_attributes(params[:ticket_type])
        format.html { redirect_to event_path(@attendee.event), notice: 'Attendee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_types/1
  # DELETE /ticket_types/1.json
  def destroy
    @attendee = Attendee.find(params[:id])
    
    @event = @attendee.event
    
    @attendee.destroy

    respond_to do |format|
      format.html { redirect_to event_path(@attendee.event), notice: 'Attendee was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
