module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history_name = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(var_name) }
        define_method("#{name}_history".to_sym) { instance_variable_get(var_history_name) }

        history = instance_variable_get(var_history_name)
        history ||= []

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          instance_variable_set(var_history_name, history << value)
        end
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym      
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Wrong class' unless value.is_a? type
        instance_variable_set(var_name, value)
      end
    end
  end
end
