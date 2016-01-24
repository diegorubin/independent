FactoryGirl.define do

  factory :gallery do
    title Faker::Commerce.product_name

    factory :gallery_with_image do
      items {build_list :gallery_item, 1}
    end

  end

end

