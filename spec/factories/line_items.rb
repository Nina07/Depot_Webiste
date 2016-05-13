FactoryGirl.define do

  factory :line_item do
    # item
    association :product , factory: :stuff, strategy: :build
    product_id 8
  end
end
