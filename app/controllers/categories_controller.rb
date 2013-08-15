class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @subscribe = current_user ? current_user.subscribes : nil
    if params[:comment]
      @images = @category.images.order('comments_count DESC').page(params[:page]).per(5)
    else
      @images = @category.images.order('likes_count DESC').page(params[:page]).per(5)
    end
  end

end