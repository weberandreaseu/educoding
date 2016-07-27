class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :class_files, as: :codeable, dependent: :destroy
  accepts_nested_attributes_for :class_files
  attr_accessor :user_dir

  def run
    serialize
    gradle
  end

  def serialize
    self.user_dir = File.join("content", "user_#{self.user.id}")
    src_dir = File.join(user_dir, "src")
    class_file_dir = File.join(src_dir, "main", "java")
    FileUtils::mkdir_p(class_file_dir)
    FileUtils.cp File.join("gradle", "java.gradle"), File.join(user_dir, "build.gradle")

    files = self.class_files + self.task.class_files.hidden
    files.each do |class_file|
      file = File.new(File.join(class_file_dir, class_file.filename), 'w')
      file.syswrite(class_file.code)
    end
    stdin = File.new(File.join(src_dir, 'stdin'), 'w')
    stdin.syswrite("Input")
  end

  def gradle
    result = `cd #{user_dir} && gradle run -Pmain=Main`
  end
end