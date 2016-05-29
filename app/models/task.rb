class Task < ActiveRecord::Base
  has_many :class_files, dependent: :destroy
  accepts_nested_attributes_for :class_files
end
