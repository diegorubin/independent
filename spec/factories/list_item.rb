FactoryGirl.define do

  factory :list_item do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    author 'autor'
    category 'categoria'
    resource_type 'Post'
    resource_id '000000123'
    slug {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    published_at Time.now
  end

end

