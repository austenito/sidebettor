require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetType do
  before(:each) do
    @valid_attributes = {
      :bet_type => "Bet Type"
    }
  end

  it "should create a new instance given valid attributes" do
    BetType.create!(@valid_attributes)
  end
end
