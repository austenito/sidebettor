require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should succeed creating a new :valid_user from the Factory" do
    Factory.create(:default_user)
  end

  it "should invalid :invalid_user factory" do
    Factory.build(:invalid_user).should nil
  end
end
