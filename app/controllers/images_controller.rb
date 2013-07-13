class ImagesController < ApplicationController

  def index

    @images = Image.page(params[:page]).per(5)
    @categories = Category.all

    session[:return_to] = request.fullpath
    #url = 'http://api.jquery.com/ready/'
    #doc = Nokogiri::HTML(open(url))
    #logger.info doc.at_css("h2 .logo a").attr('title')
  end
  def show

  end

end
