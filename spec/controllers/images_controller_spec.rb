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
    it "assigns @images" do
      get :index
      expect(assigns(:images)).to eq(@images)
    end
    it "renders the :index" do
      get :index
      assigns(:images).to_a.should match_array @images
      response.should render_template :index
    end
    it "assigns the @image" do
      get :show, id: @image
      assigns(:image).should eq(@image)
    end
    it "renders the #show" do
      get :show, id: FactoryGirl.create(:image, :category => @category)
      response.should render_template :show
    end
  end
end