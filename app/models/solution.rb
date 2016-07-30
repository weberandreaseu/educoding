class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :class_files, as: :codeable, dependent: :destroy
  accepts_nested_attributes_for :class_files
  attr_accessor :user_dir, :custom_input, :stdin, :basic, :stdout, :compiler_message

  def run
    serialize
    gradle
    read_results
    FileUtils.rm_rf(self.user_dir)
  end

  private

  def serialize
    self.user_dir = File.join('content', "user_#{self.user.id}")
    src_dir = File.join(user_dir, 'src')
    class_file_dir = File.join(src_dir, 'main', 'java')
    test_dir = File.join(src_dir, 'test', 'java')
    FileUtils::mkdir_p(class_file_dir)
    FileUtils::mkdir_p(test_dir)
    FileUtils.cp File.join('gradle', 'java.gradle'), File.join(user_dir, 'build.gradle')

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
    command = "cd #{user_dir} && gradle run build"
    if self.task.main.empty?
      return
    else
      command += " -Pmain=#{self.task.main}"
    end
    unless self.task.package.empty?
      command += " -Ppackage=#{self.task.package}"
    end
    `#{command}`
  end

  def read_results
    build_dir = File.join(user_dir, 'build')
    @stdout = read_file(File.join(build_dir, 'stdout.log'), 'No output')
    @compiler_message = read_file(File.join(build_dir, 'compile.log'), 'Compilation successful')
    @compiler_message.gsub!(File.absolute_path(user_dir), '') unless @compiler_message == 'Compilation successful'

    basic_file = open_file(File.join(build_dir, 'test-results', 'TEST-BasicTest.xml'))
    advanced_file = open_file(File.join(build_dir, 'test-results', 'TEST-AdvancedTest.xml'))

    if basic_file && advanced_file
      @basic = create_xml(basic_file)
      @advanced = create_xml(advanced_file)
      merge_test_result
      @advanced = nil
    elsif basic_file
      @basic = create_xml(basic_file)
    elsif advanced_file
      @advanced = create_xml(advanced_file)
      @basic = @advanced
      @advanced = nil
    end
  end

  def create_xml(file)
    remove_unnecessary_attributs(Nokogiri::XML(file))
  end

  def remove_unnecessary_attributs(doc)
    node = doc.xpath('testsuite')
    node.remove_attr('name')
    node.remove_attr('timestamp')
    node.remove_attr('hostname')
    nodes = doc.xpath('//testcase')
    nodes.remove_attr('classname')
    doc
  end

  def merge_test_result
    testcases = @advanced.search('testcase')
    @basic.at('testsuite').add_child(testcases)
    @basic.at('testsuite').each do |key, value|
      add_attribute(key, value)
    end
  end

  def add_attribute(key, value)
    if key == 'time'
      @basic.at('testsuite')[key] = (value.to_f + @advanced.at('testsuite')[key].to_f).round(4)
    else
      @basic.at('testsuite')[key] = value.to_i + @advanced.at('testsuite')[key].to_i
    end
  end

  def open_file(path)
    begin
      File.open(path)
    rescue
      nil
    end
  end

  def read_file(path, message=nil)
    file = nil
    begin
      IO.read(path)
    rescue
      message
    end
  end
end