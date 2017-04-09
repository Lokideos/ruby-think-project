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
             
        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          instance_variable_set(var_history_name, 
            if instance_variable_get(var_history_name).nil?
              [] << value
            elsif instance_variable_get(var_history_name).last != value
              instance_variable_get(var_history_name) << value    
            else           
              instance_variable_get(var_history_name)
            end)          
        end        
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym      
      define_method(name) { instance_variable_get(var_name) } 
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, 
          if value.class.to_s.downcase != type.to_s
            raise 'Bad class'
          else
            value
          end)
      end
    end

  end

end