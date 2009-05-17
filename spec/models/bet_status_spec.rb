require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetStatus do
  before(:each) do
    @valid_attributes = {
      :is_pending => false,
      :is_completed => true,
      :bet_id => 1,
      :winner_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    BetStatus.create!(@valid_attributes)
  end
end
