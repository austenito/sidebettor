require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetStatusesController do
  it "should show the bet status to complete" do
    bet_status_mock = mock(BetStatus)
    BetStatus.should_receive(:find).once.and_return(bet_status_mock)
    bet_status_mock.should_receive(:bet_id)
    
    user_mock = mock(User)
    User.should_receive(:find).twice.and_return(user_mock)
        
    bet_mock = mock(Bet)
    Bet.should_receive(:find).once.and_return(bet_mock)
    bet_mock.should_receive(:user).once.and_return(user_mock)
    bet_mock.should_receive(:get_challenger).once.and_return(user_mock)
        
    get 'show'
  end
  
  it "should update bet" do
    bet_status_mock = mock(BetStatus)
    BetStatus.should_receive(:find).once.and_return(bet_status_mock)    
    bet_status_mock.should_receive(:update_attributes).once.with(:is_completed => true, :winner_id => 2)
            
    get 'update', :bet_status => { :winner_id => 2 }, :id => 1
    response.should redirect_to(dashboard_path)
  end
  
  it "should not complete bet" do
    get 'update', :bet_status => {}
    response.should redirect_to(dashboard_path)
  end
end
