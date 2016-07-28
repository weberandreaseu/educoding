class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :class_files, as: :codeable, dependent: :destroy
  accepts_nested_attributes_for :class_files
  attr_accessor :user_dir, :custom_input, :stdin

  def run
    serialize
    gradle
    read_results
  end

  private

  def serialize
    self.user_dir = File.join("content", "user_#{self.user.id}")
    src_dir = File.join(user_dir, "src")
    class_file_dir = File.join(src_dir, "main", "java")
    test_dir = File.join(src_dir, "test", "java")
    FileUtils::mkdir_p(class_file_dir)
    FileUtils::mkdir_p(test_dir)
    FileUtils.cp File.join("gradle", "java.gradle"), File.join(user_dir, "build.gradle")

    files = self.class_files + self.task.class_files.hidden
    files.each do |class_file|
      file = File.new(File.join(class_file_dir, class_file.filename), 'w')
      file.syswrite(class_file.code)
    end
    stdin = File.new(File.join(src_dir, 'stdin'), 'w')
    stdin.syswrite(self.stdin)
    basic_test = File.new(File.join(test_dir, 'BasicTest.java'), 'w')
    basic_test.syswrite(self.task.basic_test)
    advanced_test = File.new(File.join(test_dir, 'AdvancedTest.java'), 'w')
    advanced_test.syswrite(self.task.advanced_test)
  end

  def gradle
    result = `cd #{user_dir} && gradle run build -Pmain=Main`
  end


  # https://stackoverflow.com/questions/31008613/merge-two-xml-files-in-nokogiri
  def read_results
    build_dir = File.join(user_dir, 'build')
    basic = File.open(File.join(build_dir, 'test-results', 'TEST-BasicTest.xml')) { |f| Nokogiri::XML(f) }
    advanced = File.open(File.join(build_dir, 'test-results', 'TEST-AdvancedTest.xml')) { |f| Nokogiri::XML(f) }

    testcases = advanced.search('testcase')
    basic.at('testsuite').add_child(testcases)

    @basic = Hash.from_xml(basic.to_s)["testsuite"]
    @advanced = Hash.from_xml(advanced.to_s)["testsuite"]

    # summarize test suites
    overwrite_hash("tests")
    overwrite_hash("skipped")
    overwrite_hash("failures")
    overwrite_hash("errors")
    overwrite_hash("time")

    compiler = IO.read(File.join(build_dir, 'compile.log'))
    compiler.gsub! File.absolute_path(user_dir), ''
    stdout = IO.read(File.join(build_dir, 'stdout.log'))
    result = TestResult.new(compiler_message: compiler, stdout: stdout, test: @basic)
  end

  def overwrite_hash(key)
    unless key == 'time'
      @basic[key] = @advanced[key].to_i + @basic[key].to_i
    else
      @basic[key] = @advanced[key].to_f + @basic[key].to_f
    end
  end
end