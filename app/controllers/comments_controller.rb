class CommentsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

  def create
    @image = Image.find(params[:image_id])
    @comment = current_user.comments.build(params[:comment])
    @comment.image_id = @image.id
    if @comment.save
      Resque.enqueue(CommentEvent, @comment.id)
      Pusher['test-channel'].trigger('test-event',comment: @comment, image: @comment.image.url, user: current_user.name)
      #image = current_user.image ? current_user.image : '/avatar.gif'
      @comments = Image.find(params[:image_id]).comments.includes(:commentable).order('created_at DESC').page(params[:page]).per(4)
      redirect_to image_path(@image)
    else
      render :json=>{:errors => @comment.errors.full_messages}
    end

  end
end
