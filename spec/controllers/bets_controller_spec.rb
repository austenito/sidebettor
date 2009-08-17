require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetsController do
  require "authlogic/test_case" # include at the top of test_helper.rb
  setup :activate_authlogic # run before tests are executed
    
  before(:each) do
    UserSession.create Factory.build(:default_user)
    
    @bet_attributes = {:title => '', :user_id => 1, :prize => {:name => "prize name"}, 
                                                    :bet_condition => {:condition => "bet_condition"}}
  end
      
  # note that user_id parameter returns the same id because the UserSession.create mock 
  # is returning the same mock object for every User.find call.      
  it "Should redirect to the dashboard when a new bet is successfully created" do
    bet_mock = mock(Bet)
    Bet.should_receive(:new).and_return(bet_mock)
    bet_mock.should_receive(:save).twice.and_return(true)    
    bet_mock.should_receive(:build_prize).once
    # bet_mock.should_receive(:create_bet_status).with({:is_completed => false, :is_pending => true})
            
    bet_condition_mock = mock(BetCondition)  
    bet_mock.should_receive(:bet_conditions).once.and_return(bet_condition_mock)
    bet_condition_mock.should_receive(:build).once.with({:condition=> "bet_condition" })

    bet_request_mock = mock(BetRequest)  
    bet_mock.should_receive(:bet_requests).twice.and_return(bet_request_mock)
    bet_request_mock.should_receive(:build).once.with({:has_accepted => true, :user_id => 1} )
    bet_request_mock.should_receive(:build).once.with({:has_accepted => false, :user_id => 1} )    
    
    get 'create', :bet => @bet_attributes
    response.should redirect_to(dashboard_path)
  end
  
  it "Should not redirect to dashboard when a new bet fails to be created" do
    bet_mock = mock(Bet)
    Bet.should_receive(:new).and_return(bet_mock)
    bet_mock.should_receive(:save).once.and_return(false)    
    get 'create', :bet => @bet_attributes
  end
  
  it "Should delete an existing bet" do
    bet_mock = mock(Bet)
    Bet.should_receive(:find).and_return(bet_mock)
    bet_mock.should_receive(:destroy).and_return(true)
    
    get 'destroy'
    response.should redirect_to(dashboard_path)    
  end
  
  it "Should not delete if a bet doesn't exist" do
    bet_mock = mock(Bet)
    Bet.should_receive(:find).and_return(bet_mock)
    bet_mock.should_receive(:destroy).and_return(false)
    
    get 'destroy'
    response.should redirect_to(dashboard_path)    
  end
end
