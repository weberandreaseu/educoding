class Task < ApplicationRecord
  has_many :class_files, as: :codeable, dependent: :destroy
  has_many :solutions
  accepts_nested_attributes_for :class_files, allow_destroy: true

  # TODO validate main extention
end
