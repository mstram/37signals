class BelongingsController < ApplicationController
  # GET /belongings
  # GET /belongings.xml
  def index
    @belongings = Belonging.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @belongings }
    end
  end

  # GET /belongings/1
  # GET /belongings/1.xml
  def show
    @belonging = Belonging.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @belonging }
    end
  end

  # GET /belongings/new
  # GET /belongings/new.xml
  def new
    @belonging = Belonging.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @belonging }
    end
  end

  # GET /belongings/1/edit
  def edit
    @belonging = Belonging.find(params[:id])
  end

  # POST /belongings
  # POST /belongings.xml
  def create
    @belonging = Belonging.new(params[:belonging])

    respond_to do |format|
      if @belonging.save
        flash[:notice] = 'Belonging was successfully created.'
        format.html { redirect_to(@belonging) }
        format.xml  { render :xml => @belonging, :status => :created, :location => @belonging }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @belonging.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /belongings/1
  # PUT /belongings/1.xml
  def update
    @belonging = Belonging.find(params[:id])

    respond_to do |format|
      if @belonging.update_attributes(params[:belonging])
        flash[:notice] = 'Belonging was successfully updated.'
        format.html { redirect_to(@belonging) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @belonging.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /belongings/1
  # DELETE /belongings/1.xml
  def destroy
    @belonging = Belonging.find(params[:id])
    @belonging.destroy

    respond_to do |format|
      format.html { redirect_to(belongings_url) }
      format.xml  { head :ok }
    end
  end
end
