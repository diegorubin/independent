FactoryGirl.define do 

  factory :snippet do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    code {(0..55).map{('a'..'z').to_a[rand(26)]}.join }
    language 'ruby'
  end

end

