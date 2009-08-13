require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetCondition do
  before(:each) do
    @valid_attributes = {
      :condition => 'Bet Condition',
      :bet_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    BetCondition.create!(@valid_attributes)
  end
end
