class EventsController < ApplicationController
  # before_action :

  def index
    @events = Event.upcoming
    if params[:search]
    	@events = Event.where("UPPER(name) like UPPER(?) OR UPPER(extended_html_description) like UPPER(?)", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
  	
  	@event = Event.new(event_params.merge(user_id: current_user.id))
  	
  	if @event.valid?
  		@event.save
  		flash[:message] = "You have just created #{@event.name} successfully"
  		redirect_to event_path(@event)
  	else
  		flash[:error] =" something wrong"
  	end
  end

  def new
  	@event = Event.new
    @events = Event.all
    @my_events = Event.my_events(current_user.id)
  end

  def update
  	raise 'testing'
  end

  def publish
    @event = Event.find(params[:id])
    @event.publish_at = Time.now
    
    if @event.valid?
      @event.save
      flash[:success] = "You have published #{@event.name}"
      redirect_to root_path
    else
      flash[:error] = "You cannot publish #{@event.name}"
      redirect_to root_path
    end
  end

  private

  def event_params
  	params.require(:event).permit(:name, :hero_image_url, :extended_html_description, :starts_at, :ends_at, :venue_id,:category_id, :user_id, :publish_at)
  end

end
