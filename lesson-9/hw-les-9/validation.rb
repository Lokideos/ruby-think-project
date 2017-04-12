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
      @validations[name] << { type: type, argument: argument }
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
        var_value = instance_variable_get("@#{var}".to_sym)
        validations.each do |validation|
          method_name = "validate_#{validation[:type]}".to_sym
          send(method_name, var_value, validation[:argument])
        end
      end
    end

    private

    def validate_presence(value, _arg)
      raise 'Value is nil or empty, which is not acceptable' if value.nil?
    end

    def validate_format(value, format_template)
      raise 'Format is wrong' unless value.to_s =~ format_template
    end

    def validate_type(value, class_template)
      raise 'Class of this value is wrong' unless value.is_a? class_template
    end
  end
end
