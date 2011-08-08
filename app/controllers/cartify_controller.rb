class CartifyController < ApplicationController

	layout "restaurants"

  def add
		#TODO: check price

		atom = CartItem.new( params )
		current_cart.add_item(atom)

		render :json => current_cart
  end

end
