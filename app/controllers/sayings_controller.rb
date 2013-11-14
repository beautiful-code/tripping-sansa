class SayingsController < ApplicationController
  # GET /sayings
  # GET /sayings.json
  def index
    @sayings = Saying.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sayings }
    end
  end

  # GET /sayings/1
  # GET /sayings/1.json
  def show
    @saying = Saying.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @saying }
    end
  end

  # GET /sayings/new
  # GET /sayings/new.json
  def new
    @saying = Saying.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @saying }
    end
  end

  # GET /sayings/1/edit
  def edit
    @saying = Saying.find(params[:id])
  end

  # POST /sayings
  # POST /sayings.json
  def create
    @saying = Saying.new(params[:saying])

    respond_to do |format|
      if @saying.save
        format.html { redirect_to request.referer, notice: 'Saying was successfully created.' }
        format.json { render json: @saying, status: :created, location: @saying }
      else
        format.html { render action: "new" }
        format.json { render json: @saying.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sayings/1
  # PUT /sayings/1.json
  def update
    @saying = Saying.find(params[:id])

    respond_to do |format|
      if @saying.update_attributes(params[:saying])
        format.html { redirect_to @saying, notice: 'Saying was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @saying.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sayings/1
  # DELETE /sayings/1.json
  def destroy
    @saying = Saying.find(params[:id])
    @saying.destroy

    respond_to do |format|
      format.html { redirect_to sayings_url }
      format.json { head :no_content }
    end
  end
end
