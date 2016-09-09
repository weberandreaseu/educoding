class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :class_files, as: :codeable, dependent: :destroy
  accepts_nested_attributes_for :class_files
  attr_accessor :user_dir, :custom_input, :stdin, :basic, :stdout, :error_message, :final

  def run
    serialize
    gradle
    read_results
    FileUtils.rm_rf(self.user_dir)
  end

  private

  def serialize
    @user_dir = File.join('content', "user_#{self.user.id}")
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

    write_file(File.join(src_dir, 'stdin'), self.stdin)
    write_file(File.join(test_dir, 'BasicTest.java'), self.task.basic_test)
    write_file(File.join(test_dir, 'AdvancedTest.java'), self.task.advanced_test)
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
    @error_message = read_file(File.join(build_dir, 'error.log'), 'Compilation successful')
    @error_message.gsub!(File.absolute_path(user_dir), '') unless @error_message == 'Compilation successful'

    basic_file = open_file(File.join(build_dir, 'test-results', 'TEST-BasicTest.xml'))
    advanced_file = open_file(File.join(build_dir, 'test-results', 'TEST-AdvancedTest.xml'))

    if basic_file && advanced_file && self.final
      @basic = create_xml(basic_file)
      @advanced = create_xml(advanced_file)
      merge_test_result
      @advanced = nil
    elsif basic_file
      @basic = create_xml(basic_file)
    elsif advanced_file && self.final
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

  def write_file(path, content)
    file = File.new(path, 'w')
    file.syswrite(content)
  end
end