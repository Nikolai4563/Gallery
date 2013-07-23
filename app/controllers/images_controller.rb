class ImagesController < ApplicationController
  def index
    if params[:comment]
      @images = Image.order('comments_count DESC').page(params[:page]).per(5)
    elsif params[:like]
      @images = Image.order('likes_count DESC').page(params[:page]).per(5)
    else
      @images = Image.page(params[:page]).per(5)
    end

    session[:return_to] = request.fullpath
  end
  def show
    @image = Image.find(params[:id])
    @comments = @image.comments.order('created_at DESC').page(params[:page]).per(4)
  end

end
