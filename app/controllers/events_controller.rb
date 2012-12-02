class EventsController < ApplicationController
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])

  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new (params[:event])
    @event.group_id = session[:group_id]

    if @event.save
      session[:group_id] = nil
      redirect_to @event, notice: "Event was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to @event, notice: "Event was successfully edited"
    else
      render action: "edit"
    end
  end

  def destroy
    @event = Event.find(params:[id])
    @event.destroy
  end
end