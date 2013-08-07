require 'spec_helper'

describe CommentsController do
  before :each do
    @category = FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user)
    @category.users << @user
    @image = FactoryGirl.create(:image, :category => @category)
  end
  describe "routes" do
    it "route to #new" do
      expect(:get => "/images/1/comments/new").to route_to(:action => "new", :controller => "comments", :image_id => "1")
    end
    it "route to #create" do
      expect(:post => "/images/1/comments").to route_to(:action => "create", :controller => "comments", :image_id => "1")
    end
  end
  describe 'Create' do
    it "Comment" do
      sign_in @user
      post :create, {:image_id => @image, :comment => {:body=>'comment'}}
      response.should redirect_to(image_path(@image))
    end
    it "save the new comennt" do
      sign_in @user
      expect{
        post :create,{:image_id => 1, :comment => {:body=>'comment'}}
      }.to change(Comment,:count).by(1)
    end
    it "save the new comennt" do
      sign_in @user
      post :create,{:image_id => 1, :comment => {:body=>nil}}
      body = JSON.parse(response.body)
      body['errors'].should == ["Body can't be blank"]
    end
    it "Unauthorized" do
      post :create,{:image_id => 1, :comment => {:body=>"123123123"}}
      response.should redirect_to(new_user_session_path)
    end

  end
end
