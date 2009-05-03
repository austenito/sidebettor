require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BetRequest do
  before(:each) do
    @valid_attributes = {
      :is_pending => true,
      :has_accepted => false,
      :bet_id => 1,
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    BetRequest.create!(@valid_attributes)
  end
end
