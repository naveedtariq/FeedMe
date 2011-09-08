class LocationsController < ApplicationController

  layout 'restaurants'
  skip_before_filter :require_location
#before_filter :ensure_authenticated

	def index
		session[:at] = nil
	end

  def new
    @location = current_user.locations.build
    @user_id = current_user.id

    @user_locations = Location.find(:all, :conditions => "user_id = #{@user_id}")
	  @home_location = Location.find(:first, :conditions => "user_id = #{@user_id} and is_home_address = 1")
	  @selected_id = nil
	  @selected_id = @home_location.id if @home_location
    @user_locations = nil
	  @home_location = nil
	  @selected_id = nil
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end
  
  def create
    @user_id = current_user.id

	  session[:order_method] = params[:commit]
		params[:location][:active] = 1

		self.deactivate_all_locations

		if params[:location][:is_home_address] == "1"
			@user_id = current_user.id
			@locations = Location.find(:all, :conditions => "user_id = #{@user_id} and is_home_address = 1")
			@locations.each do |location|
				location.is_home_address = 0
				if location.save
					flash[:notice] = params[:location][:is_home_address]
				end
			end
		end

		puts "---------------------------------------------------"
		@location = current_user.locations.build(params[:location])
		puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++"
		session[:current_location] = @location

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Your address has been updated'
        format.html { redirect_to params[:redirect_to] || :controller => :restaurants, :action => :index, :sort => "cuisine" }
        format.xml  { render :xml => @location, :status => :created, :location => user_location_path(@user, @location) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors }
      end
    end
  end
  
   def set
   	session[:order_method] = params[:commit]
   	@user_id = current_user.id
  	if params[:saved_location] != "0"
		@locations = Location.find(:all, :conditions => "user_id = #{@user_id} and active = 1")
		@locations.each do |location|
			location.active = 0
			location.save
		end
		@home_location = Location.find(params[:saved_location])
		@home_location.active = 1
		session[:current_location] = @home_location
		respond_to do |format|
			  if @home_location.save
				flash[:notice] = 'Your location has been updated'
				format.html { redirect_to params[:redirect_to] || :controller => :restaurants, :action => :index, :sort => "cuisine" }
				format.xml  { render :xml => @home_location, :status => :created, :location => user_location_path(@user, @home_location) }
			  else
				format.html { render :action => "new" }
				format.xml  { render :xml => @home_location.errors }
			  end
		end
	else 
		
		flash[:notice] = 'You must select a valid location'
		puts "You must select a valid location\n\n\n\n\n************************************************************"
		redirect_to :action => "new"
	end
 end
  
  protected
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def find_location(id = params[:id])
      current_user.locations.find(id)
    end

		def deactivate_all_locations
			@locations = Location.find(:all, :conditions => "user_id = #{@user_id} and active = 1")
			@locations.each do |location|
				location.active = 0
				location.save
			end
		end
end
