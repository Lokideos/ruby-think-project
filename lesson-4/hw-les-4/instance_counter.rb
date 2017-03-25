module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0
    attr_accessor :instances    
  end

  module InstanceMethods
    def register_instance
      self.class.instances += 1
    end    
  end
end