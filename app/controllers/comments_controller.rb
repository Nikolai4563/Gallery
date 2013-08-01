class CommentsController < ApplicationController

  before_filter :authenticate_user!, :except => [:new, :create]


  def new
    @comment = current_user.comments.new
  end

  def create
    @image = Image.find(params[:image_id])
    @comment = current_user.comments.new(params[:comment])
    @comment.image_id = @image.id
    if @comment.save
      ActiveSupport::Notifications.instrument("comments.create", :comment => @comment)
      Pusher['test-channel'].trigger('test-event',comment: @comment, image: @comment.image.url, user: @comment.commentable.name)
    end
    image = @comment.commentable.image ? @comment.commentable.image : '/avatar.gif'
    respond_to do |format|
      format.json { render :json => {:author => @comment.commentable.name ,:comment => @comment.body, :image => image, :date => @comment.created_at.strftime("%d %B %Y %H:%M")} }
      format.html { redirect_to image_path(@image) }
    end

  end
end
