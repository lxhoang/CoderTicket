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
    @ticket = TicketType.new(ticket_params)
    @ticket.event_id = params[:event_id].to_i

    if @ticket.valid?
      @ticket.save
      flash[:success] = "Create ticket type successfully"
      redirect_to event_tickets_path
    else
      flash[:error] = "Cannot create ticket type"
      redirect_to 'new'
    end
  end

  private

  def ticket_params
  	params.require(:ticket_type).permit(:name, :price, :max_quantity, :event_id)
  end

end
