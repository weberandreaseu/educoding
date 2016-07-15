class ClassFile < ActiveRecord::Base
  belongs_to :codeable, polymorphic: true

  def self.visible
    where(visible: true)
  end
  
  def self.hidden
    where(visible: false)
  end
end
