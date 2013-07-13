class LikesController < ApplicationController
  def create
    like = current_user.likes.where(:image_id => params[:image_id])
    if !like.blank?
      like.destroy_all
    else
      @like = current_user.likes.create(:image_id => params[:image_id])
    end
    render :json => {}
  end
end