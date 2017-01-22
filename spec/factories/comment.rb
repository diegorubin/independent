FactoryGirl.define do

  factory :comment do
    name "Um comentarista"
    email "algumacoisa@gmail.com"
    site "http://google.com"
    body "um comentario"
    published false 
    association :commentable, factory: :post

    factory :comment_published do
      published true
    end

  end

end

