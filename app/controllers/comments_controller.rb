class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @comment = current_user.comments.new
  end

  def create
    @image = Image.find(params[:image_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.image_id = @image.id
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:alert] = 'Comment create error.'
    end
    redirect_to images_path
  end
end
