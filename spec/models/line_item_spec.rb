require 'spec_helper'

describe LineItem do
  it "has product id not blank" do
    expect(FactoryGirl.build(:line_item, product_id: 5)).to be_valid
  end
end
