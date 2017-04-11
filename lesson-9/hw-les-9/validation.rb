module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    attr_reader :validations

    def validate(name, type, argument = nil)    
      @validations ||= {}
      @validations[name] ||= []
      @validations[name] << {type: type, argument: argument}    
    end   

  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    def validate!
      self.class.validations.each do |var, validations|        
        var_name = instance_variable_get("@#{var}".to_sym)     
        validations.each do |validation|
          method_name = "validate_#{validation[:type]}".to_sym                                
          method_argument = validation[:argument]          
          send(method_name, var_name, method_argument)
        end
      end
    end

    def validate_presence(name, argument)      
      raise 'Value is nil or empty, which is not acceptable' if name.nil?
    end

    def validate_format(name, argument)      
      raise 'Format is wrong' unless name.to_s =~ argument
    end

    def validate_type(name, argument)      
      raise 'Class of this value is wrong' unless name.is_a? argument
    end

  end
end
