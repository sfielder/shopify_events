class ProductsController < ApplicationController
  
  around_filter :shopify_session
  
  # GET /Products
  # GET /Products.json
  def index
    
    
      @products_previous = Product.previous.order_by(:starttime.asc)
      @products_upcoming = Product.upcoming.order_by(:starttime.asc)
      @products = Product.all.order_by(:starttime.asc)
      
      puts "################## #{@products_previous.count}"
      puts "################## #{@products_upcoming.count}"
      puts "################## #{@products.count}"
      
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /Products/1
  # GET /Products/1.json
  def show
    @product = Product.find(params[:id])
    puts "################## #{Variant.where(product_id: params[:id]).to_json}"
    @variant = Variant.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /Products/new
  # GET /Products/new.json
  def new
    @product = Product.new
    @variant = Variant.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /Products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /Products
  # POST /Products.json
  def create
    puts "****************************PARAMS #{params}"
    @product = Product.new(params[:product])
    
    respond_to do |format|
      if @product.save!
        format.html { redirect_to event_path(@product), notice: 'Event was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /Products/1
  # PUT /Products/1.json
  def update
    puts "****************************PARAMS #{params}"
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to event_path(@product), notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Products/1
  # DELETE /Products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
