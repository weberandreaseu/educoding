# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    title "Java Hello World"
    description "Please implement Hello Word in Java"
    score 4

    factory :task_with_class_files do
      after(:create) do |task|
        create(:class_file, task: task)
      end
    end

  end
end
