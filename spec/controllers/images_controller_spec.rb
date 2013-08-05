require 'spec_helper'

describe ImagesController do
  describe "GET index" do
    before :each do
      @category = FactoryGirl.create(:category)
      @user = FactoryGirl.create(:user)
      @category.users << @user
      FactoryGirl.create(:image, :category => @category)
      @image = FactoryGirl.create(:image, :category => @category)
      @image.comments << FactoryGirl.create(:comment_user, :image => @image)
      @images = Image.all
    end
    it 'Sorted by Like' do
      get :index
      assigns[:images].should == @images
    end
    it 'Sorted by Comment' do
      get :index, :comment => 'comment'
      assigns[:images].should == @images.reverse
    end
    it 'renders the :index' do
      get :index
      assigns(:images).to_a.should match_array @images
      response.should render_template :index
    end
    it 'assigns the @image' do
      get :show, id: @image
      assigns(:image).should eq(@image)
    end
    it 'renders the #show' do
      get :show, id: FactoryGirl.create(:image, :category => @category)
      response.should render_template :show
    end
    it 'show root' do
      expect(:get => "images/#{@image.id}").to route_to(:action => 'show', :controller => 'images', :id=>"#{@image.id}")
    end
    it 'index root' do
      expect(:get => 'images/').to route_to(:action => 'index', :controller => 'images')
    end
    it 'root' do
      expect(:get => '/').to route_to(:action => 'index', :controller => 'images')
    end
    it 'search' do
      post :search ,:image => {:title =>'image' }
      images = Image.where("title LIKE ?",'%image%').order("created_at DESC")
      expect (images.count.should == 2 )
      expect assigns(:images)== images
    end
    it 'search' do
      post :search ,:image => {:title =>'ololo' }
      images = Image.where("title LIKE ?",'%ololo%').order("created_at DESC")
      expect (images.count.should == 0 )
      expect assigns(:images)== images
    end
  end
end