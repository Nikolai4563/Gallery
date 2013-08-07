class ImagesController < ApplicationController

  def index
    if params[:comment]

      @search = Image.order('comments_count DESC').page(params[:page]).per(5).ransack(params[:q])
      @images = @search.result
    else
      @search = Image.order('likes_count DESC').page(params[:page]).per(5).ransack(params[:q])
      @images = @search.result

    end
    session[:return_to] = request.fullpath
  end
  def show
    @image = Image.find(params[:id])
    FNORD_METRIC.event(@image.attributes.merge(_type: :view_image))
    @comments = @image.comments.includes(:commentable).order('created_at DESC').page(params[:page]).per(4)
  end
  def search
    index
    render :index
  end
end
