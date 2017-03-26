module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance

    def instances_to_zero
      @instance = 0    
    end

    def add_instance
      @instance += 1
    end
  end

  module InstanceMethods

    protected 

    def register_instance
      self.class.add_instance
    end    
  end
end