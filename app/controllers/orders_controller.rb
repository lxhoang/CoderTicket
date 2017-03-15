class OrdersController < ApplicationController
  
  def index
  	@event = Event.find(params[:event_id])
    @ticket = TicketType.new
  end

  def new
  	@event = Event.find(params[:event_id])
  	@order = Order.new
  end

  def create

  	orders = params[:quantity]
  	message = ""
	orders.to_a.each do |ticket_type_id, quantity|
		ticket_type_id = ticket_type_id.to_i
		quantity = quantity.to_i
		ticket_type = TicketType.find(ticket_type_id)

		if is_ticket_quantity_valid?(ticket_type_id: ticket_type_id, quantity: quantity) && quantity > 0
			order = Order.new(ticket_type_id: ticket_type_id, quantity: quantity)
			order.user_id = current_user.id
			order.event_id = ticket_type.event_id

			if order.valid?
				order.save
				ticket_type.max_quantity = (ticket_type.max_quantity - quantity)
				ticket_type.save
				# raise 'testing'
				message << "Hi #{current_user.name}. \n" if message.empty?
				message << "You current order successfully for #{quantity} tickets for \"#{ticket_type.name}\" with price \"#{ticket_type.price}\"\n"
				flash[:success] = message
			else 
				flash[:error] = "You cannot order ticket"
			end
		else
			
		end

	end

	redirect_to '/upcoming'
  end

  def destroy

  end

  def is_ticket_quantity_valid?(ticket_type_id:, quantity:)
  	result = false
  	return true if quantity == 0

  	case quantity
  	when 0
  		return true
	when (0..9)
  		max_quantity = TicketType.find(ticket_type_id).max_quantity
  		result = max_quantity > quantity
  		flash[:error] = "We do not have enough #{quantity} ticket #{TicketType.find(ticket_type_id)} for at the moment. Please contact us for more information" unless result
  		return result 
  	else 
  		flash[:error] = "At current, we do not support #{quantity} ticket for one order"
  	end
  	
  	result
  end
end
