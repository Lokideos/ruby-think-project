module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance_counter

  end

  module InstanceMethods

    protected 

    def register_instance
      if self.class.instance_counter
        self.class.instance_counter += 1
      else
        self.class.instance_counter = 1
      end
    end    
    
  end
end