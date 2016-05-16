FactoryGirl.define do
  factory :user do
    firstname "John"
    lastname  "Doe"
    email { "#{firstname}@#{lastname}.com".downcase }
    password "1234"
  end
end