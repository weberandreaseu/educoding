class ClassFile < ActiveRecord::Base
  belongs_to :codeable, polymorphic: true
end
