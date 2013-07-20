class SubscribesController < ApplicationController
  before_filter :authenticate_user!
  def create
    subscribe = current_user.subscribes.where(:category_id => params[:category_id])

    if !subscribe.blank?
      subscribe.destroy_all
    else
      @subscribe = current_user.subscribes.create(:category_id => params[:category_id])
    end
    render :json => {}

  end
end