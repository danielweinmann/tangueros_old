class EventsController < ApplicationController
  
  inherit_resources
  actions :index, :create
  
  def index
    @happening = Event.happening.all
    @upcoming = Event.upcoming.all
    @past = Event.past.all
  end
  
end
