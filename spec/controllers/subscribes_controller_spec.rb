require 'spec_helper'

describe SubscribesController do
  describe "Create" do
    before :each do
      @category = FactoryGirl.create(:category)
      @user = FactoryGirl.create(:user)
      @image = FactoryGirl.create(:image, :category => @category)
    end
    it "Sign_in" do
      sign_in @user
      post :create, {:category_id => @category}
      response.status.should == 200
    end
    it "Subscribe" do
      sign_in @user
      post :create, {:category_id => @category}
      Subscribe.count.should == 1
    end
    it "Subscribe" do
      sign_in @user
      post :create, {:category_id => @category}
      Subscribe.count.should == 1
    end
    it "Unsubscribe" do
      sign_in @user
      post :create, {:category_id => @category}
      post :create, {:category_id => @category}

      Subscribe.count.should == 0
    end
    it "Unauthorized" do
      sign_out @user
      post :create, {:category_id => @category}
      response.should redirect_to(new_user_session_path)
    end
    it "route to #create" do
      expect(:post => "/subscribes").to route_to(:action => "create", :controller => "subscribes")
    end

  end
end