FactoryGirl.define do

  factory :gallery_item do
    title Faker::Commerce.product_name
    description 'gallery item description'
    slug {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
  end

end

