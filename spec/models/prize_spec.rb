require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Prize do
  before(:each) do
    @valid_attributes = {
      :name => "Prize",
      :bet_id => 1,
      :prize_category_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Prize.create!(@valid_attributes)
  end
end
