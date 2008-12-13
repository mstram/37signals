class SeparatorsController < ApplicationController
  # GET /separators
  # GET /separators.xml
  def index
    @separators = Separator.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @separators }
    end
  end

  # GET /separators/1
  # GET /separators/1.xml
  def show
    @separator = Separator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @separator }
    end
  end

  # GET /separators/new
  # GET /separators/new.xml
  def new
    @separator = Separator.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @separator }
    end
  end

  # GET /separators/1/edit
  def edit
    @separator = Separator.find(params[:id])
  end

  # POST /separators
  # POST /separators.xml
  def create
    @separator = Separator.new(params[:separator])

    respond_to do |format|
      if @separator.save
        flash[:notice] = 'Separator was successfully created.'
        format.html { redirect_to(@separator) }
        format.xml  { render :xml => @separator, :status => :created, :location => @separator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @separator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /separators/1
  # PUT /separators/1.xml
  def update
    @separator = Separator.find(params[:id])

    respond_to do |format|
      if @separator.update_attributes(params[:separator])
        flash[:notice] = 'Separator was successfully updated.'
        format.html { redirect_to(@separator) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @separator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /separators/1
  # DELETE /separators/1.xml
  def destroy
    @separator = Separator.find(params[:id])
    @separator.destroy

    respond_to do |format|
      format.html { redirect_to(separators_url) }
      format.xml  { head :ok }
    end
  end
end
