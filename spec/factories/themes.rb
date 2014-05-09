FactoryGirl.define do

  factory :theme do
    label {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    title 'default'

    factory :theme_invalid do
      title ''
    end
  end

end

