class EventsController < ApplicationController
	#showing the both sets of list of events
  def index
  	@events = Event.all
  	# @event = Event.find(params[:id])
  	@user = User.find(session[:user_id])
  	# @not_attending = Event.where(:location => { :location_id => nil})

  	# if @user.location.state != @event.location.state

  		#grab all the events and print them that aren't of the user's state
  end

# showing the event specific information
  def profile
  	@event = Event.find(params[:id])
  	# @user = User.find(params[:id])
  	# event = Event.find(params[:id])
  	# user = User.find(params[:id])
  	@attend = Attendance.where(event: Event.find(params[:id]))
  	@comment = Comment.where(event: Event.find(params[:id]))
  	@comments = Comment.find_by(event: params[:id])
  end

  def ecreate
  	user = User.find_by(id: session[:user_id])
  	if Location.find_by(city: params[:city])
  		location = Location.find_by(city: params[:city])
  	else
  		location = Location.create(city: params[:city], state: params[:state])
  	end
	Event.create(name: params[:name], date: params[:date], location: location, user: user)
	redirect_to "/events"
  end

  def join
  	user = User.find_by(id: session[:user_id])
  	event = Event.find(params[:id])
  	attendance = Attendance.create(user: user, event: event)
  	redirect_to "/events"
  end
end
