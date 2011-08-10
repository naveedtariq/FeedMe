class OrdersController < ApplicationController

	layout "restaurants"

	def show
		render :json => session.to_json;
#		render :json => current_cart
	end

  def create 
		#TODO: check price

		render :json => session.to_json;
#	atom = CartItem.new( params )
		
#		current_user.id
#		current_cart.add_item(atom)
  end

end
