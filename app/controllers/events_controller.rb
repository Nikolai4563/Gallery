class EventsController < ApplicationController
  def index
    @user = User.all
  end

  def show
    type = request.url.split("/").last
    case type
      when 'sign_in', 'sign_out'
        @events = Event.where(:eventable_type => type.capitalize,:user_id => params[:user_id])
      when 'like', 'comment'
        @events = Event.where(:eventable_type => type.capitalize,:user_id => params[:user_id]).includes(:eventable => :image)
      else
        @events = Event.where(:eventable_type => type.capitalize,:user_id => params[:user_id]).preload(:eventable)
    end

  end

end