class BpacksController < ApplicationController
  # GET /bpacks
  # GET /bpacks.xml
  def index
    @bpacks = Bpack.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bpacks }
    end
  end

  # GET /bpacks/1
  # GET /bpacks/1.xml
  def show
    @bpack = Bpack.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bpack }
    end
  end

  # GET /bpacks/new
  # GET /bpacks/new.xml
  def new
    @bpack = Bpack.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bpack }
    end
  end

  # GET /bpacks/1/edit
  def edit
    @bpack = Bpack.find(params[:id])
  end

  # POST /bpacks
  # POST /bpacks.xml
  def create
    @bpack = Bpack.new(params[:bpack])

    respond_to do |format|
      if @bpack.save
        flash[:notice] = 'Bpack was successfully created.'
        format.html { redirect_to(@bpack) }
        format.xml  { render :xml => @bpack, :status => :created, :location => @bpack }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bpack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bpacks/1
  # PUT /bpacks/1.xml
  def update
    @bpack = Bpack.find(params[:id])

    respond_to do |format|
      if @bpack.update_attributes(params[:bpack])
        flash[:notice] = 'Bpack was successfully updated.'
        format.html { redirect_to(@bpack) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bpack.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bpacks/1
  # DELETE /bpacks/1.xml
  def destroy
    @bpack = Bpack.find(params[:id])
    @bpack.destroy

    respond_to do |format|
      format.html { redirect_to(bpacks_url) }
      format.xml  { head :ok }
    end
  end
end
