class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  #before_filter :select_category

  def append_info_to_payload(payload)
    super
    payload[:uid] = current_user.id if user_signed_in?
  end
  def select_category
    @categories = Category.all
  end
end
