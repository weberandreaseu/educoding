class ClassFile < ActiveRecord::Base
  belongs_to :code, polymorphic: true
end
