FactoryGirl.define do
  factory :product , aliases: [:item, :stuff] do
    transient do
      hottest_product true
      upcased false
    end
    sequence(:title, 5) {|n| "Readers Digest#{n}-Hottest Product if #{hottest_product }" }#inline sequence
    price 500
    image_url ""
    description "Cool and interesting stuff for book worms!!"

    after(:create) do |product, evaluator|
      product.title.upcase! if evaluator && evaluator.upcased
    end

    factory :product_with_line_items do
        transient do
          items_count 5
        end

        after(:create) do |product,evaluator|
          create_list(:line_item, evaluator.items_count, product: product)
        end
      end
    end
end
