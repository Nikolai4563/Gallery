require 'spec_helper'

describe EventsController do
  before :each do
    @comment = Event.create(:eventable_type => 'Comment',:eventable_id => 1, :user_id => 1)
    @like = Event.create(:eventable_type => 'Like',:eventable_id => 1, :user_id => 1)
    @sign_in = Event.create(:eventable_type => 'Sign_in',:eventable_id => 1, :user_id => 1)
    @sign_out = Event.create(:eventable_type => 'Sign_out',:eventable_id => 1, :user_id => 1)
    @navigation = Event.create(:eventable_type => 'Naviation',:eventable_id => 1, :user_id => 1)
  end
  it 'renders the #show' do
    get :show, id: @navigation
    response.should render_template :show
  end
  it 'Show event comment' do
    get :show, id: @comment
    assigns[:event].should == @comment
  end
  #it 'Show event like' do
  #  get :show, id: @like
  #  assigns[:like].should == @like
  #end
  #it 'Show event sign_in' do
  #  get :show, id: @sign_in
  #  assigns[:events].should == @sign_in
  #end
  #it 'Show event sign_out' do
  #  get :show, id: @sign_out
  #  assigns[:events].should == @sign_out
  #end
  #it 'show root' do
  #  expect(:get => "events/#{@navigation.id}").to route_to(:action => 'show', :controller => 'events', :id=>"#{@navigation.id}")
  #end
end