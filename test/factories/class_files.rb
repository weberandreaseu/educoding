# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :class_file do
    code  'class HelloWorld {'\
          '    public static void main (String[] args) {'\
          '        System.out.println("Hello World!");'\
          '    }'\
          '}'
    filename "HelloWorld.java"
  end
end
