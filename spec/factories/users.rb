# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email {(0..5).map{('a'..'z').to_a[rand(26)]}.join+"@example.com" }
    name {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    password "queroentrar"
  end

end
