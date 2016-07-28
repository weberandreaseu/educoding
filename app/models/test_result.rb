class TestResult
  include ActiveModel::Model
  attr_accessor :compiler_message, :stdout
end