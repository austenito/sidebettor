require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetStatusesController do
  it "should update bet" do
    bet_status_mock = mock(BetStatus)
    BetStatus.should_receive(:find).once.and_return(bet_status_mock)    
    bet_status_mock.should_receive(:is_completed=).once
    bet_status_mock.should_receive(:save).once
      
    get 'update'
    response.should redirect_to(dashboard_path)
  end

end
