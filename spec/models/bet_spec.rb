require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bet do
  before(:each) do
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
end
