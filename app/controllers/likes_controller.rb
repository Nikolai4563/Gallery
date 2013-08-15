class LikesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]
  def create
    expire_fragment "image#{current_user.id}"
    like = current_user.likes.where(:image_id => params[:image_id])
    if !like.blank?
      like.destroy_all
    else
      @like = current_user.likes.create(:image_id => params[:image_id])
      Resque.enqueue(LikeEvent, @like.id)


    end
    count = Like.where(:image_id => params[:image_id]).count
    render :json => {:count=> count}
  end
end