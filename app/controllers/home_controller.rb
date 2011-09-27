class HomeController < ApplicationController
  def index
  	@title = "Columbus Georgia Calendar of Events"

    @events = Event.paginate(:page => params[:page], :per_page => 10)
  end

end
