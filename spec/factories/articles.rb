FactoryGirl.define do
  factory :article do
    title 'a' * 20
    content 'a' * 20
    user
    category
  end
end
