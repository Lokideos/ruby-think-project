require 'set'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, argument = nil)
      var_type = "validate_#{type}".to_sym
      # p "Inside validate: #{name}, #{type}, #{argument}"
      @validations ||= {}
      @validations[name] ||= []
      @validations[name] << var_type
      create_methods(var_type, argument)
    end

    def create_methods(var_type, argument)
      case var_type
      when :validate_presence
        define_method(var_type) do |name|
          name = "@#{name}".to_sym
          raise 'Value is nil or empty, which is not acceptable' if instance_variable_get(name).nil?
        end

      when :validate_format
        define_method(var_type) do |name|
          name = "@#{name}".to_sym
          raise 'Format is wrong' unless instance_variable_get(name).to_s =~ argument
        end

      when :validate_type
        define_method(var_type) do |name|
          name = "@#{name}".to_sym
          raise 'Class of this value is wrong' unless instance_variable_get(name).is_a? argument
        end
      end
    end

    def validations
      @validations
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
        # p "#{var}: #{validations}"
        value = instance_variable_get("@#{var}")
        # p "#{value}"
        validations.each do |validation|
          # p "#{validation}"
          send(validation.to_sym, var.to_sym)
        end
      end
    end
  end
end
