class TestResult
  include ActiveModel::Model
  attr_accessor :compiler_message, :stdout, :test
end