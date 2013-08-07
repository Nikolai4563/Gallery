class EventsController < ApplicationController
  def index
    @user = User.all
  end

  def sign_in
    @events = Event.where(:eventable_type => 'Sign_in',:user_id => params[:user_id])
  end
  def sign_out
    @events = Event.where(:eventable_type => 'Sign_out',:user_id => params[:user_id])
  end
  def navigation
    @events = Event.where(:eventable_type => 'Navigation',:user_id => params[:user_id]).preload(:eventable)
  end
  def like
    @events = Event.where(:eventable_type => 'Like',:user_id => params[:user_id]).includes(:eventable => :image)
  end
  def comment
    @events = Event.where(:eventable_type => 'Comment',:user_id => params[:user_id]).includes(:eventable => :image)
  end

end