require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetRequestsController do
  require "authlogic/test_case" # include at the top of test_helper.rb
  setup :activate_authlogic # run before tests are executed
    
  before(:each) do
    UserSession.create Factory.build(:default_user)
  end
  
  it "should request be accepted" do
    bet_request_mock = mock(BetRequest)
    BetRequest.should_receive(:find).and_return(bet_request_mock)
    bet_request_mock.should_receive(:each).once
    
    bet_mock = mock(Bet)
    Bet.should_receive(:find).and_return(bet_mock)
    bet_mock.should_receive(:is_active=).once.with(true)
    bet_mock.should_receive(:is_closed=).once.with(false)    
    bet_mock.should_receive(:save).once.and_return(true)
    
    get 'update', :has_accepted => true
    response.should redirect_to(dashboard_path)
  end

  it "should request be denied" do
    bet_request_mock = mock(BetRequest)
    BetRequest.should_receive(:find).and_return(bet_request_mock)
    bet_request_mock.should_receive(:each).once
    
    bet_mock = mock(Bet)
    Bet.should_receive(:find).and_return(bet_mock)
    bet_mock.should_receive(:is_active=).once.with(false)
    bet_mock.should_receive(:is_closed=).once.with(true)
    bet_mock.should_receive(:save).once.and_return(true)
    
    get 'update', :has_accepted => false
    response.should redirect_to(dashboard_path)
  end
end
