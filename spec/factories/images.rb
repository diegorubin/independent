FactoryGirl.define do

  factory :image do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    slug {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    file {File.open(image_example_path)}

    factory :image_invalid do
      title ''
    end
  end

end

