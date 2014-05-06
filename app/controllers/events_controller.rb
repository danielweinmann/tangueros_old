#coding: utf-8

class EventsController < ApplicationController
  
  inherit_resources
  respond_to :html, :json, :xml
  custom_actions collection: :sitemap  

  after_action :verify_authorized, except: %i[index sitemap]
  after_action :verify_policy_scoped, only: %i[index sitemap]

  def index
    @events = policy_scope(Event)
    index! do |format|
      format.html do
        @happening = @events.happening
        @upcoming = @events.upcoming
        @past = @events.past.limit(6)
      end
    end
  end

  def show
    show!
    authorize @event
  end

  def new
    new!
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    authorize @event
    create!
  end

  def sitemap
    @events = policy_scope(Event)
    sitemap! do |format|
      format.xml do
        @happening = @events.happening
        @upcoming = @events.upcoming
        @past = @events.past
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(:url, :event_type_id)
  end

end
