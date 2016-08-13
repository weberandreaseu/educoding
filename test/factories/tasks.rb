# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    title "Java Hello World"
    description "Please implement Hello Word in Java"
    score 4
    main "Run"
    package ""
    stdin "John"
    basic_test <<~HEREDOC
      import static org.junit.Assert.*;
      import org.junit.Test;

      public class BasicTest {
        @Test
        public void testSayHello() {
            Solution solution = new Solution();
          assertEquals("Hello Rails", solution.sayHello("Rails"));
        }
      }
      HEREDOC

    factory :task_with_class_files do
      after(:create) do |task|
        create(:class_file_solution, codeable: task)
      end
      after(:create) do |task|
        create(:class_file_run, codeable: task)
      end
    end

  end
end
