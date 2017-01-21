FactoryGirl.define do

  factory :setting do
    title {(0..5).map{('a'..'z').to_a[rand(26)]}.join }
    category 'categoria'
    theme 'default'
    value 'value'

    factory :feature_comments do
      title 'comments'
      category 'features'
      theme 'global'
      value 'enabled'
    end
  end

end

