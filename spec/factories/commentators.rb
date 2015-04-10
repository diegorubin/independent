FactoryGirl.define do
  factory :commentator do
    name Faker::Name.name
    email Faker::Internet.email
    active true

    factory :commentator_inactive do
      active false
    end
  end
end

