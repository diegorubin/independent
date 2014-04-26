FactoryGirl.define do 

  factory :presentation do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    slug {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    published true
  end

end

