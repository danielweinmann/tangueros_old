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
  
  def show
    show!
  end
  
  def create
    create! do |success, failure|
      failure.html do
        flash[:failure] = "#{@event.errors.full_messages[0]}. Tem certeza de que copiou o link correto para o evento? Tenta de novo, de repente ;)" unless @event.errors.full_messages.empty?
        redirect_to :root
      end
      success.html do
        flash[:success] = "O evento foi adicionado com sucesso. Agora é só curtir e compartilhar :D"
        redirect_to event_path(@event)
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      failure.html do
        flash[:failure] = @event.errors.full_messages[0] unless @event.errors.full_messages.empty?
        redirect_to :root
      end
      success.html do
        flash[:success] = "O evento foi excluido com sucesso :D"
        redirect_to :root
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
  
end
