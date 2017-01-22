FactoryGirl.define do 

  factory :presentation do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    published true
    resume 'resumo'
    author 'autor'
    category 'apresentacao'

    factory :presentation_invalid do
      title ''
    end

    factory :simple_presentation do
      title 'Simple presentation'
      file File.open(File.dirname(__FILE__) + "/../models/examples/presentation.pdf")
      tags 'example,test'
    end
  end

end

