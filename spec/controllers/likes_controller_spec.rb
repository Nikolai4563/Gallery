require 'spec_helper'

describe LikesController do
  describe "Create" do
    before :each do
      @category = FactoryGirl.create(:category)
      @user = FactoryGirl.create(:user)
      @category.users << @user
      @image = FactoryGirl.create(:image, :category => @category)
    end
    it "Sign_in" do
      sign_in @user
      post :create, {:image_id => @image}
      response.status.should == 200
    end
    it "Like" do
      sign_in @user
      post :create, {:image_id => @image}
      Like.count.should == 1
    end
   it "Dislike" do
      sign_in @user
      post :create, {:image_id => @image}
      post :create, {:image_id => @image}
      Like.count.should == 0
    end
    it "Unauthorized" do
      sign_out @user
      post :create, {:image_id => @image}
      response.should redirect_to(new_user_session_path)
    end
    it "route to #create" do
      expect(:post => "/likes").to route_to(:action => "create", :controller => "likes")
    end
  end
end