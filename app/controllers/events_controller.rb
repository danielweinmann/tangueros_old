class EventsController < ApplicationController
  
  inherit_resources
  actions :index, :create
  
  def index
    @happening = Event.happening.all
    @upcoming = Event.upcoming.all
    @past = Event.past.limit(6).all
    @event_types = EventType.all
    @event = Event.new event_type: EventType.first
  end
  
  def create
    create! do |success, failure|
      failure.html do
        flash[:failure] = "#{@event.errors.full_messages[0]}. Tem certeza de que copiou o link correto para o evento? Tenta de novo, de repente ;)" unless @event.errors.full_messages.empty?
        return redirect_to :root
      end
      success.html do
        flash[:success] = "O evento foi adicionado com sucesso. Muito obrigado! :D"
        return redirect_to :root
      end
    end
  end
  
  def sitemap
    @happening = Event.happening.all
    @upcoming = Event.upcoming.all
    @past = Event.past.all
  end
  
end
