class ImagesController < ApplicationController
  def showcase
    @images = Image.all
  end
  def index
    if params[:comment]
      @search = Image.order('comments_count DESC').page(params[:page]).per(5).ransack(params[:q])
      @images = @search.result
    else
      @search = Image.order('likes_count DESC').page(params[:page]).per(5).ransack(params[:q])
      @images = @search.result
    end
    @subscribe = current_user ? current_user.subscribes : nil
    session[:return_to] = request.fullpath
  end
  def show
    @image = Image.find(params[:id])
    #@image.trigger_view_event
    @comments = @image.comments.includes(:commentable).order('created_at DESC').page(params[:page]).per(4)
  end
  def search
    index
    render :index
  end
end
