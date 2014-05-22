FactoryGirl.define do

  factory :image do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    file File.open(Rails.root.join("spec/models/examples/image.jpg"))

    factory :image_invalid do
      title ''
    end
  end

end

