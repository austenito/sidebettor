require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetsController do
  require "authlogic/test_case" # include at the top of test_helper.rb
  setup :activate_authlogic # run before tests are executed
    
  before(:each) do
    UserSession.create Factory.build(:default_user)
  end
      
  it "Should create a new bet" do
    # Creates the mocks for a prize and it's category
    prize_category_mock = mock(PrizeCategory)
    PrizeCategory.should_receive(:new).once.and_return(prize_category_mock)
    prize_category_mock.should_receive(:save).once
    
    prize_mock = mock(Prize)
    Prize.should_receive(:new).once.and_return(prize_mock)
    prize_mock.should_receive(:save).once
          
    # Creates the mocks for a Bet
    bet_mock = mock(Bet)
    Bet.should_receive(:new).and_return(bet_mock)
    bet_mock.should_receive(:bet_conditions).twice.and_return(Array.new)
    bet_mock.should_receive(:bet_requests).twice.and_return(Array.new)    
    bet_mock.should_receive(:save).once.and_return(true)
    
    # Creates the mocks for a BetRequest
    bet_request_mock = mock(BetRequest)
    BetRequest.should_receive(:new).twice.and_return(bet_request_mock)
        
    # Creates the mocks for a BetCondition
    bet_condition_mock = mock(BetCondition)
    BetCondition.should_receive(:new).twice.and_return(bet_condition_mock)
    
    # Creates the mocks for a BetRatio
    bet_ratio_mock = mock(BetRatio)
    BetRatio.should_receive(:new).twice.and_return(bet_ratio_mock)
    bet_ratio_mock.should_receive(:save).twice    
    
    # Test a request to create bet.
    user_bet_conditions = { :bet_type_id => 1, :condition => 'User Condition'} 
    challenger_bet_conditions = { :bet_type_id => 1, :condition => 'Challenger Condition', :user_id => 2} 
    get 'create', :bet => {:title => '', :user_bet_conditions => user_bet_conditions, :challenger_bet_conditions => challenger_bet_conditions}
    
    response.should redirect_to(dashboard_path)
  end
end
