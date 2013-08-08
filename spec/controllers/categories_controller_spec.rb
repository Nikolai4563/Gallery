require 'spec_helper'

describe CategoriesController do
  describe "Create" do
    before :each do
      @category = FactoryGirl.create(:category)
      @user = FactoryGirl.create(:user)
      @category.users << @user
      @images = [FactoryGirl.create(:image, :category => @category),FactoryGirl.create(:image, :category => @category)]
      @like = @user.likes << Like.create( :image_id => @images[0].id)
    end

    it 'renders the #show' do
      get :show, id: @category
      response.should render_template :show
    end
    it 'Sorted by Like' do
      get :show, id: @category
      assigns[:user].should == @images
    end
    it 'Sorted by Comment' do
      get :show, id: @category, :comment => 'comment'
      assigns[:user].should == @images.reverse
    end
    it 'show root' do
      expect(:get => "categories/#{@category.id}").to route_to(:action => 'show', :controller => 'categories', :id=>"#{@category.id}")
    end
  end
end
