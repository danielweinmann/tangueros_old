#coding: utf-8

class EventsController < ApplicationController
  
  inherit_resources
  respond_to :html, :json, :xml
  custom_actions collection: :sitemap  

  after_action :verify_authorized, except: %i[index sitemap]
  after_action :verify_policy_scoped, only: %i[index sitemap]
  before_action :authenticate_user!, only: %i[new]

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
    show! { authorize @event }
  end

  def new
    new! { authorize @event }
  end

  def create
    set_start_and_end_params!
    @event = Event.new(event_params)
    @event.user = current_user
    authorize @event
    create!(notice: "Evento criado com sucesso! Agora é só compartilhar :D")
  end

  def edit
    edit! { authorize @event }
  end

  def update
    set_start_and_end_params!
    authorize resource
    update!(notice: "Evento atualizado com sucesso :D")
  end

  def destroy
    authorize resource
    destroy!(notice: "Evento excluído com sucesso :D") { root_path }
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

  def permitted_params
    params.permit(event: [:name, :event_type_id, :starts_at, :ends_at, :description, :location, :address, :image, :url])
  end

  def event_params
    params.require(:event).permit(:name, :event_type_id, :starts_at, :ends_at, :description, :location, :address, :image, :url)
  end

  def set_start_and_end_params!
    params[:event][:starts_at] = "#{params[:starts_at_date_submit]} #{params[:starts_at_time_submit]}" unless params[:event][:starts_at].present?
    params[:event][:ends_at] = "#{params[:ends_at_date_submit]} #{params[:ends_at_time_submit]}" unless params[:event][:ends_at].present?
  end

end
