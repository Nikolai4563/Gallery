class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    if params[:comment]
      @images = @category.images.order('comments_count DESC').page(params[:page]).per(5)
    else
      @images = @category.images.order('likes_count DESC').page(params[:page]).per(5)
    end
  end

end