require 'spec_helper'

describe Product do
  it "has a valid factory" do
    expect(create(:product)).to be_valid
  end
  it "is invalid without a title and title has to be unique" do
    expect(create(:product, title: "one")).to be_valid #positive test case
    create(:product) do |product|
      puts product.line_items.create(attributes_for(:line_item))
    end
    expect(build(:product, title: "one")).to_not be_valid #negative
  end
  it "has price greater than zero" do
    expect(build(:product, price: '-100')).to_not be_valid
  end
  it "has upcase title" do #instance method test 
    expect(build(:product, title: "sam").do_upcase == "SAM").to be_truthy
  end

  describe "filtering by first letter" do
    before do
      create(:product, title: "Public Enemies")
      create(:product, title: "Xbox")
    end
    it "has matching letter first letter" do #class method test
      expect(Product.begin_with_check("P") == "Public Enemies").to be_truthy
    end
    it "has non matching letter first letter" do
      expect(Product.begin_with_check("H") == "Public Enemies").to be_falsy
    end
  end
end


  # before do
  #   @product = Product.create(title: "GK", price: 50, description: "General Knowledge", created_at: Time.now)
  # end
  # it "shows the newly added Product first" do
  #     @latest_product = Product.create(title: "Math", price: 250, description: "Mathematics", created_at: Time.now+60)
  #     byebug
  #       expect(Product.order('created_at desc').all == [@latest_product, @product]).to be_valid
  # end
    
