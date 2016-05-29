# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_file do
    code "MyText"
    filename "MyString"
    task_id 1
  end
end
