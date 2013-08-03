class LikesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  def create
    like = current_user.likes.where(:image_id => params[:image_id])
    if !like.blank?
      like.destroy_all
    else
      @like = current_user.likes.create(:image_id => params[:image_id])
      ActiveSupport::Notifications.instrument("likes.create", :like => @like)
      logger.info @like
      logger.info '@'*100
    end
    count = Like.where(:image_id => params[:image_id]).count
    render :json => {:count=> count}
  end
end