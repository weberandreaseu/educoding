class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :class_files, as: :codeable, dependent: :destroy
  accepts_nested_attributes_for :class_files

  def run
    dir = serialize
    execute dir
  end

  def serialize
    dir = Dir.mktmpdir "test"
    self.class_files.each do |class_file|
      file = File.new(dir + '/' + class_file.filename, 'w')
      file.syswrite(class_file.code)
    end
    dir
  end

  def execute(dir)
    filename = self.class_files.first.filename
    compile_command = "javac #{dir}/#{filename} -d #{dir}"
    run_command = "cd #{dir} && java #{File.basename(filename, '.java')}"
    compilation_result = `#{compile_command}`
    if compilation_result.empty?
      return `#{run_command}`
    else
      return compilation_result
    end
  end
end