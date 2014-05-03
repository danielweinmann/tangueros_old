#coding: utf-8

class EventsController < ApplicationController
  
  inherit_resources
  respond_to :html, :json, :xml
  custom_actions collection: :sitemap  

  def index
    index! do |format|
      format.html do
        @happening = Event.happening
        @upcoming = Event.upcoming
        @past = Event.past.limit(8)
      end
    end
  end
  
  def sitemap
    sitemap! do |format|
      format.xml do
        @happening = Event.happening
        @upcoming = Event.upcoming
        @past = Event.past
      end
    end
  end

  private

  def permitted_params
    params.permit(event: [:url, :event_type_id])
  end

end
