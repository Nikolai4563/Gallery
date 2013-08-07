require 'spec_helper'

describe EventsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @comment = Event.create(:eventable_type => 'Comment',:eventable_id => 1, :user_id => @user.id)
    @like = Event.create(:eventable_type => 'Like',:eventable_id => 1, :user_id => @user.id)
    @sign_in = Event.create(:eventable_type => 'Sign_in',:eventable_id => 1, :user_id => @user.id)
    @sign_out = Event.create(:eventable_type => 'Sign_out',:eventable_id => 1, :user_id => @user.id)
    @navigation = Event.create(:eventable_type => 'Navigation',:eventable_id => 1, :user_id => @user.id)
    @user = User.all
  end
  it 'Navigation event' do
    get :navigation, :user_id => 1
    expect(assigns(:events).should include @navigation)
  end
  it 'Like event' do
    get :like, :user_id => 1
    expect(assigns(:events).should include @like)
  end
  it 'Comment event' do
    get :comment, :user_id => 1
    expect(assigns(:events).should include @comment)
  end
  it 'Sign_in event comment' do
    get :sign_in, :user_id => 1
    expect(assigns(:events).should include @sign_in)
  end
  it 'Sign_out event comment' do
    get :sign_out, :user_id => 1
    expect(assigns(:events).should include @sign_out)
  end
  it  'index test' do
    get :index
    assigns[:user].should == @user
  end
  it 'navigation root' do
    expect(:get => "events/navigation/1").to route_to(:action => 'navigation', :controller => 'events', :user_id => '1')
  end
  it 'sign_in root' do
    expect(:get => "events/sign_in/1").to route_to(:action => 'sign_in', :controller => 'events', :user_id => '1')
  end
  it 'sign_out root' do
    expect(:get => "events/sign_out/1").to route_to(:action => 'sign_out', :controller => 'events', :user_id => '1')
  end
  it 'like root' do
    expect(:get => "events/like/1").to route_to(:action => 'like', :controller => 'events', :user_id => '1')
  end
  it 'comment root' do
    expect(:get => "events/comment/1").to route_to(:action => 'comment', :controller => 'events', :user_id => '1')
  end
  it 'index root' do
    expect(:get => "events").to route_to(:action => 'index', :controller => 'events')
  end

end