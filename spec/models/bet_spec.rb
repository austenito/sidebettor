require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bet do
  before(:each) do
    @valid_attributes = {
      :title => "Bet Title",
      :end_date => Date.today,
      :user_id => 1,
      :prize_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Bet.create!(@valid_attributes)
  end
end
