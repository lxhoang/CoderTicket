class EventsController < ApplicationController
  def index
    @events = Event.upcoming
    if params[:search]
    	@events = Event.where("UPPER(name) like UPPER(?) OR UPPER(extended_html_description) like UPPER(?)", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
