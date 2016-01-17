FactoryGirl.define do

  factory :gallery_item do
    title Faker::Commerce.product_name
    description Faker::Lorem.paragraph(2)
  end

end

