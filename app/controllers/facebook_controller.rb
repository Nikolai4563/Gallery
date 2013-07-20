class FacebookController < ApplicationController

  def create
    auth = (env['omniauth.auth'])
    #render :text => (env['omniauth.auth'])
    @user = User.find_or_create_by_uid(:uid => auth['uid']) do |user|
      user.password = Devise.friendly_token[0,20]
      user.email = "#{auth['provider']}@#{auth['info']['nickname']}.ru"
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
      user.image = auth['info']['image']
    end
    if sign_in @user
      ActiveSupport::Notifications.instrument("sessions.create", :user => current_user)
    end

    redirect_to root_path

  end

end