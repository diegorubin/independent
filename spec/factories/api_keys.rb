FactoryGirl.define do

  factory :api_key do
    user_id { FactoryGirl.create(:user).id.to_s }
    program { Faker::App.name }
    permissions { { posts: [:create] } }
  end

end

