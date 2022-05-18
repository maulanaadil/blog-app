FactoryGirl.define do 
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    role 'user'
    password '123456'
    password_confirmation '123456'
  end
end #FAKER https://github.com/faker-ruby/faker
