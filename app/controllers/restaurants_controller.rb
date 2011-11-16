class RestaurantsController < ApplicationController

#include PublicSection
#include GeoKit::Geocoders
	
#caches_page :index, :show

require 'will_paginate/array'

  def index
		@location = current_location
		conditions = {:datetime => 'ASAP', :postal_code => @location.zip.split("-")[0], :city => @location.city, :street_address => @location.street}
		@details = Restaurant.restaurants(conditions).paginate(:page => params[:page], :per_page => 6)		
	end
	
    def sorted
    	@location = current_location
		conditions = {:datetime => 'ASAP', :postal_code => @location.zip.split("-")[0], :city => @location.city, :street_address => @location.street}
		@details = Restaurant.restaurants(conditions).paginate(:page => params[:page], :per_page => 6)		
    	
    	## Sort the array alphabetically
		@details = @details.sort do |a,b|
		  a.name.upcase <=> b.name.upcase
		end
		##
		
		@details
		
		render :index
    end

	def favorites
		all = current_user.favourite_restaurants
		ids = all.map {|x| x.restaurant_id }		
		@details = Restaurant.from_ids(ids)
		@details = @details.paginate(:page => params[:page], :per_page => 3)
	end


	def show
		@restaurant = Restaurant.restaurant( params[:id] )
		@cart = current_cart

		unless @restaurant.nil?
			session[:restaurant_id] = @restaurant.id
		end
#puts "\n\n-------************\n\n" + @cart.inspect + "\n\n*********************************************\n\n"
	end

	def add_favorite
		fv = FavouriteRestaurant.new({:user_id => current_user.id, :restaurant_id => params[:restaurant_id]})
		fv.save
		render :json => fv.to_json
	end

	def remove_favorite
		fv = FavouriteRestaurant.where(:user_id => current_user.id, :restaurant_id => params[:restaurant_id])
		fv.first.delete
		render :json => {:message => "deleted"}
	end

end
