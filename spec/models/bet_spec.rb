require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bet do
  require "authlogic/test_case" # include at the top of test_helper.rb
  setup :activate_authlogic # run before tests are executed
    
  before(:each) do
    @session = UserSession.create Factory.build(:default_user)
    
    @valid_attributes = {
      :title => "Bet Title",
      :end_date => Date.today,
      :user_id => 1
    }
    
    @pending_request_attributes = {
      :has_accepted => false,
      :bet_id => 1,
      :user_id => 1      
    }
    
    @accepted_request_attributes = {
      :has_accepted => true,
      :bet_id => 1,
      :user_id => 1      
    }
  end

  it "should create a new instance given valid attributes" do
    Bet.create!(@valid_attributes)
  end
   
  it "should return challenger" do
    challenger = Factory.create(:admin_user)
    bet = Bet.create!(@valid_attributes)    
    bet.bet_requests.push(BetRequest.create!(@pending_request_attributes))
    bet.bet_requests.push(BetRequest.create!(:has_accepted => false, :bet_id => 1, :user_id => challenger.id))
    bet.get_challenger.id.should == challenger.id
  end
  
  it "should return user condition" do
    bet = Bet.create!(@valid_attributes)
    bet.get_bettor_condition.condition.should != nil    
  end
  
  it "should return challenger condition" do
    challenger = Factory.create(:admin_user)    
    bet = Bet.create!(@valid_attributes)
    bet.get_challenger_condition.condition.should != nil    
  end
  
end
