require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetRequestsController do

  it "should request be accepted" do
    bet_request_mock = mock(BetRequest)
    BetRequest.should_receive(:find).and_return(bet_request_mock)
    bet_request_mock.should_receive(:has_accepted=).with(true)
    bet_request_mock.should_receive(:is_pending=).with(false)
    bet_request_mock.should_receive(:save).once.and_return(true)
    
    get 'update', :has_accepted => true
    response.should redirect_to(dashboard_path)
  end

  it "should request be denied" do
    bet_request_mock = mock(BetRequest)
    BetRequest.should_receive(:find).and_return(bet_request_mock)
    bet_request_mock.should_receive(:has_accepted=).with(false)
    bet_request_mock.should_receive(:is_pending=).with(false)
    bet_request_mock.should_receive(:save).once.and_return(true)
    
    get 'update', :has_accepted => false
    response.should redirect_to(dashboard_path)
  end
end
