FactoryGirl.define do

  factory :asset do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }

    factory :asset_invalid do
      title ''
    end

    factory :asset_with_file do
      file File.open(Rails.root.join("spec/models/examples/test.zip"))
    end
  end

end

