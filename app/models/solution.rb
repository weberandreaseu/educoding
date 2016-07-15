class Solution < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :class_files, as: :codeable, dependent: :destroy
  accepts_nested_attributes_for :class_files

  def run
    result = ''
    self.class_files.each do |cf|
      result << cf.code
    end
    result
  end
end