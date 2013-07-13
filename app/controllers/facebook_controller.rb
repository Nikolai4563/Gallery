class FacebookController < ApplicationController

  def create
    auth = (env['omniauth.auth'])
    #render :text => (env['omniauth.auth'])
    @user = User.find_or_create_by_uid(:uid => auth['uid']) do |user|
      user.password = Devise.friendly_token[0,20]
      user.email = "#{auth['provider']}@#{auth['info']['nickname']}.ru"
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.nickname = auth['info']['nickname']
      user.image = auth['info']['image']
    end
    sign_in @user
    redirect_to session[:return_to]

  end

  def destroy
    reset_session
    redirect_to :back
  end



end