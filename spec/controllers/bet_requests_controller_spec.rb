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
    request_mocks = { bet_request_mock, bet_request_mock }
    bet_request_mock.should_receive(:each).once
    
    bet_status_mock = mock(BetStatus)
    BetStatus.should_receive(:find).and_return(bet_status_mock)
    bet_status_mock.should_receive(:update_attribute).once.with(:is_pending, false)
    
    get 'update', :has_accepted => true
    response.should redirect_to(dashboard_path)
  end

  it "should request be denied" do
    bet_request_mock = mock(BetRequest)
    BetRequest.should_receive(:find).and_return(bet_request_mock)
    bet_request_mock.should_receive(:each).once
    
    bet_status_mock = mock(BetStatus)
    BetStatus.should_receive(:find).and_return(bet_status_mock)
    bet_status_mock.should_receive(:update_attribute).once.with(:is_pending, false)    
    
    get 'update'
    response.should redirect_to(dashboard_path)
  end
end
