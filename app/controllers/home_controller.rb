class HomeController < ApplicationController
  def index
  	@title = "Columbus Georgia Calendar of Events"

    @events = Event.after_today.paginate(:page => params[:page], :per_page => 20, :order => 'starts_at ASC' )
    @featured_events = Event.featured.after_today
  end

end
