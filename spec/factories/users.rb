# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Name-#{n}"}
    sequence(:email) { |n| "email_#{n}@example.com" }
  end
end
