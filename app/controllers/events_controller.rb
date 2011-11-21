class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    @title = "Columbus Georgia Calendar of Events"

    @events = Event.date_filter(params[:from], params[:to])
                   .search(params[:keyword])
                   .group_filter(params[:group])
                   .order('starts_at')
                   .paginate(:page => params[:page], :per_page => 15 )
                   # .group_filter(params[:group])
    @featured_events = Event.featured.after_today
    @featured_events = @featured_events[rand(@featured_events.size)]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.js
    end
  end

  # GET /events/print
  def print
    @title = "Columbus GA Calendar - Print"
    @events = Event.after_today.order('starts_at')

    respond_to do |format|
      format.html
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    @title = "Columbus GA Calendar - " + @event.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
