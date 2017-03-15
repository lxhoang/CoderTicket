class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @ticket = TicketType.new
  end

  def index
  	@event = Event.find(params[:event_id])
  	@tickets = TicketType.where(event_id: @event)
  end

  def create
  	
  end

  private

  def ticket_params
  	params.require(:ticket_type).permit(:name, :price, :max_quantity)
  end

end
