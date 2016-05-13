require 'spec_helper'

describe Order do
  it "has a name value present" do
    puts FactoryGirl.attributes_for :order
    expect(FactoryGirl.build(:order, name: "Alex")).to be_valid
    expect(FactoryGirl.build(:order, name: "")).to_not be_valid
  end
  it "has an email id present" do
    expect(FactoryGirl.build(:order, email: "")).to_not be_valid
  end
end



