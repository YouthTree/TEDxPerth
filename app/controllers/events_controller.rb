class EventsController < ApplicationController

  before_filter :require_user,  :only   => [:attending, :withdraw]
  before_filter :prepare_event, :except => [:index]
  
  def index
    @upcoming_events  = Event.upcoming.all
    @completed_events = Event.completed.all
    @events_page      = Page[:events]
  end
  
  def show
    add_title_variables! :event => @event.name
  end
  
  def attending
    if can? :attend, @event
      @event.attending! current_user
      redirect_to @event, :notice => tf('events.attending', :event => @event.name)
    else
      redirect_to @event, :alert => tf('events.unable_to_attend', :event => @event.name)
    end
  end
  
  def withdraw
    if can? :withdraw, @event
      @event.withdraw! current_user
      redirect_to @event, :notice => tf('events.withdrawn', :event => @event.name)
    else
      redirect_to @event, :alert => tf('events.unable_to_withdraw', :event => @event.name)
    end
  end

  protected
  
  def prepare_event
    @event = Event.viewable.find_using_slug!(params[:id])
  end
  
end
