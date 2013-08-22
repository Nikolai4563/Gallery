class SubscribesController < ApplicationController
  before_filter :authenticate_user!
  def create
    expire_fragment "categories-caches#{current_user.id}"
    expire_fragment "category-caches#{current_user.id}"
    subscribe = current_user.subscribes.find_by_category_id(params[:category_id])
    if !subscribe.blank?
      category_name = "You describe #{subscribe.category.name}"
      subscribe.destroy
    else
      subscribe = current_user.subscribes.create(:category_id => params[:category_id])
      category_name = "You subscribe #{subscribe.category.name}"
    end
    render :json => {:success => category_name}

  end
end