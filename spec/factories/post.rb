FactoryGirl.define do 

  factory :post do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    body 'a simple body'
    author 'author'
    category 'category'
    resume 'a simple resume'

    factory :post_invalid do
      body ''
    end

    factory :simple_post do
      title 'Simple post'
      tags 'example,test'
      published true
    end
  end

end

