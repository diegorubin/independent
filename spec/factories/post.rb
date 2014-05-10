FactoryGirl.define do 

  factory :post do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    body "Apenas um corpo"
    author 'autor'
    category 'categoria'

    factory :post_invalid do
      body ""
    end
  end

end

