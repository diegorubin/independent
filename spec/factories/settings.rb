FactoryGirl.define do

  factory :setting do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    category 'categoria'
  end

end

