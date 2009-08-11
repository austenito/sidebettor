require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetsUsers do
  before(:each) do
  end  
  
  it "should create a new instance given valid attributes" do
    bets_users = BetsUsers.create!(:bet_id => 1, :user_id => 1)
    bets_users.bet_id.should == bets_users.bet_id
    bets_users.user_id.should == bets_users.user_id    
  end
end
