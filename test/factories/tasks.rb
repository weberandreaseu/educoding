# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    title "Hello World"
    description "Please implement Hello Word in Java"
    score 4
  end
end
