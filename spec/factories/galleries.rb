FactoryGirl.define do

  factory :gallery do
    title Faker::Commerce.product_name
    author 'an author'
    tags 'example,test'
    category 'category'

    factory :gallery_with_image do
      items {build_list :gallery_item, 1}
    end

    factory :simple_gallery do
      items {build_list :gallery_item, 1}
      title 'Simple gallery'
      published true
    end

  end

end

