require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bet do
  require "authlogic/test_case" # include at the top of test_helper.rb
  setup :activate_authlogic # run before tests are executed
    
  before(:each) do
    @session = UserSession.create Factory.build(:default_user)
    @challenger = Factory.create(:admin_user)
    
    @valid_attributes = {
      :title => "Bet Title",
      :end_date => Date.today,
      :user_id => 1,
      :is_closed => true,
      :is_active => true
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
    bet = Bet.create!(@valid_attributes)    
    bet.bet_requests.push(BetRequest.create!(@pending_request_attributes))
    bet.bet_requests.push(BetRequest.create!(:has_accepted => false, :bet_id => 1, :user_id => @challenger.id))
    bet.get_challenger.id.should == @challenger.id
  end
  
  it "should return user condition" do
    bet = Bet.create!(@valid_attributes)
    bet.get_bettor_condition.condition.should != nil    
  end
  
  it "should return challenger condition" do  
    bet = Bet.create!(@valid_attributes)
    bet.get_challenger_condition.condition.should != nil    
  end
  
  it "should return closed" do
    bet = Bet.create!(@valid_attributes)
    bet.is_closed.should == true
  end
  
  it "should return active" do
    bet = Bet.create!(@valid_attributes)
    bet.is_active.should == true
  end
  
  it "should return user is a participant" do
    bet = Bet.create!(@valid_attributes)    
    bet.bet_requests.push(BetRequest.create!(:has_accepted => true, :bet_id => bet.id, :user_id => @challenger.id))
    bet.is_participant(@challenger.id).should == true
  end
  
  it "should not return user is a participant" do
    bet = Bet.create!(@valid_attributes)    
    bet.bet_requests.push(BetRequest.create!(:has_accepted => true, :bet_id => bet.id, :user_id => 12))    
    bet.bet_requests.push(BetRequest.create!(:has_accepted => true, :bet_id => bet.id, :user_id => 14))    
    bet.is_participant(@challenger.id).should == false
  end
end
