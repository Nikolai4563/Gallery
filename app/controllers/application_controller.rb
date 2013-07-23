class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers

  def append_info_to_payload(payload)
    super
    payload[:uid] = current_user.id if user_signed_in?
  end
end
