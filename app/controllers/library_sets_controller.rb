class LibrarySetsController < ApplicationController
  # GET /library_sets
  # GET /library_sets.json
  def index
    @library_sets = LibrarySet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @library_sets }
    end
  end

  # GET /library_sets/1
  # GET /library_sets/1.json
  def show
    @library_set = LibrarySet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @library_set }
    end
  end

  # GET /library_sets/new
  # GET /library_sets/new.json
  def new
    @library_set = LibrarySet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @library_set }
    end
  end

  # GET /library_sets/1/edit
  def edit
    @library_set = LibrarySet.find(params[:id])
  end

  # POST /library_sets
  # POST /library_sets.json
  def create
    @library_set = LibrarySet.new(params[:library_set])

    respond_to do |format|
      if @library_set.save
        format.html { redirect_to @library_set, notice: 'Library set was successfully created.' }
        format.json { render json: @library_set, status: :created, location: @library_set }
      else
        format.html { render action: "new" }
        format.json { render json: @library_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /library_sets/1
  # PUT /library_sets/1.json
  def update
    @library_set = LibrarySet.find(params[:id])

    respond_to do |format|
      if @library_set.update_attributes(params[:library_set])
        format.html { redirect_to @library_set, notice: 'Library set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @library_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /library_sets/1
  # DELETE /library_sets/1.json
  def destroy
    @library_set = LibrarySet.find(params[:id])
    @library_set.destroy

    respond_to do |format|
      format.html { redirect_to library_sets_url }
      format.json { head :no_content }
    end
  end
end
