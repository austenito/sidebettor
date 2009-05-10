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
      :is_pending => true,
      :has_accepted => false,
      :bet_id => 1,
      :user_id => 1      
    }
    
    @accepted_request_attributes = {
      :is_pending => false,
      :has_accepted => true,
      :bet_id => 1,
      :user_id => 1      
    }
  end

  it "should create a new instance given valid attributes" do
    Bet.create!(@valid_attributes)
  end
  
  it "should be pending" do
    bet = Bet.create!(@valid_attributes)    
    bet.bet_requests.push(BetRequest.create!(@pending_request_attributes))
    bet.bet_requests.push(BetRequest.create!(@pending_request_attributes))
    bet.is_pending.should == true
  end

  it "should not be pending" do
     bet = Bet.create!(@valid_attributes)    
     bet.bet_requests.push(BetRequest.create!(@accepted_request_attributes))
     bet.bet_requests.push(BetRequest.create!(@accepted_request_attributes))
     bet.is_pending.should == false
  end
   
  it "should return challenger" do
    challenger = Factory.create(:admin_user)
    bet = Bet.create!(@valid_attributes)    
    bet.bet_requests.push(BetRequest.create!(@pending_request_attributes))
    bet.bet_requests.push(BetRequest.create!(:is_pending => false, :has_accepted => false, :bet_id => 1, :user_id => challenger.id))
    bet.get_challenger.id.should == challenger.id
  end
  
  it "should return bettor ratio" do
    challenger = Factory.create(:admin_user)
    bet = Bet.create!(@valid_attributes)    
    bet.bet_ratios.push(BetRatio.create!(:bet_id => bet.id, :user_id => bet.user_id, :ratio => 1))
    bet.bet_ratios.push(BetRatio.create!(:bet_id => bet.id, :user_id => challenger.id, :ratio => 3))
    bet.get_bettor_ratio.ratio.should == 1
  end
  
  it "should return new user ratio" do 
    bet = Bet.create!(@valid_attributes)
    bet.get_bettor_ratio.ratio.should != nil
  end
  
  it "should return new challenger ratio" do 
    challenger = Factory.create(:admin_user)
    bet = Bet.create!(@valid_attributes)
    bet.get_challenger_ratio.ratio.should != nil
  end  
  
  it "should return challenger ratio" do
    challenger = Factory.create(:admin_user)
    bet = Bet.create!(@valid_attributes)    
    bet.bet_ratios.push(BetRatio.create!(:bet_id => bet.id, :user_id => bet.user_id, :ratio => 1))
    bet.bet_ratios.push(BetRatio.create!(:bet_id => bet.id, :user_id => challenger.id, :ratio => 3))
    bet.get_challenger_ratio.ratio.should == 3
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
