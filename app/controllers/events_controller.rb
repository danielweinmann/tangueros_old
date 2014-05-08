#coding: utf-8

class EventsController < ApplicationController
  
  inherit_resources
  respond_to :html, :json, :xml
  custom_actions collection: %i[happening upcoming past sitemap]

  after_action :verify_authorized, except: %i[index happening upcoming past sitemap]
  after_action :verify_policy_scoped, only: %i[index happening upcoming past sitemap]
  before_action :authenticate_user!, only: %i[new]

  def index
    @events = policy_scope(Event)
    index! do |format|
      format.html do
        @happening = @events.happening.limit(3)
        @upcoming = @events.upcoming.limit(3)
        @past = @events.past.limit(3)
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

  def happening
    @events = policy_scope(Event).happening
    happening!
  end

  def upcoming
    @events = policy_scope(Event).upcoming
    upcoming!
  end

  def past
    @events = policy_scope(Event).past
    past!
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
    params.permit(event: [:name, :event_type_id, :starts_at, :ends_at, :description, :location, :address, :image, :url, :weekly])
  end

  def event_params
    params.require(:event).permit(:name, :event_type_id, :starts_at, :ends_at, :description, :location, :address, :image, :url, :weekly)
  end

  def set_start_and_end_params!
    if params[:starts_at_date_submit].present? && params[:starts_at_time_submit].present? && !params[:event][:starts_at].present?
      params[:event][:starts_at] = "#{params[:starts_at_date_submit]} #{params[:starts_at_time_submit]}"
    end
    if params[:ends_at_date_submit].present? && params[:ends_at_time_submit].present? && !params[:event][:ends_at].present?
      params[:event][:ends_at] = "#{params[:ends_at_date_submit]} #{params[:ends_at_time_submit]}"
    end
  end

end
