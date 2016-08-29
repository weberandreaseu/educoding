# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_file do
    factory :class_file_solution do
      filename "Solution.java"
      visible true
      code <<~HEREDOC
      public class Solution {
          public String sayHello(String name) {
              return "Hello " + name;
          }
      }
      HEREDOC
    end

    factory :class_file_run do
      filename "Run.java"
      visible false
      code <<~HEREDOC
      import java.util.*;
      public class Run {
          public static void main (String[] args) {
              Solution solution = new Solution();
              Scanner s = new Scanner(System.in);
              while(s.hasNext()) {
                  System.out.println(solution.sayHello(s.next()));
              }
          }
      }
      HEREDOC
    end
  end

end
