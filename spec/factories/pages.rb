FactoryGirl.define do

  factory :page do
    title 'uma pagina'
    body 'apenas uma pagina'

    factory :page_invalid do
      body ''
    end

  end

end

