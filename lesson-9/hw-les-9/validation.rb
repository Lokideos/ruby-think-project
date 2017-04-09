require 'set'

module Validation
  def self.included(base)    
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def validate(name, requirment = nil, argumet = nil)
      task = {requirment: requirment, argumet: argumet}

      if class_variable_defined?(:@@validating_tasks)
        tasks = class_variable_get(:@@validating_tasks)
        tasks[name] ||= []
        tasks[name] << task
        class_variable_set(:@@validating_tasks, tasks)
      else
        class_variable_set(:@@validating_tasks, name => [task])
      end
    end
  end

  #   attr_accessor :validate_types

  #   def validate(name, type, *params)
  #     var_name = "@#{name}".to_sym
  #     var_type = "#{type}".to_sym
  #     self.validate_types = Set.new if self.validate_types.nil?
  #     self.validate_types << var_type
  #     define_method(var_type) do |params|
  #       if var_type == :presence
  #         instance_variable_get(var_name).nil?          
  #       end    
  #       if var_type == :type
  #         instance_variable_get(var_name).class.to_s == params.first.to_s.capitalize          
  #       end
  #     end      
  #   end
  

  module InstanceMethods

    def validate!
      tasks_hash = self.class.class_variable_get(:@@validating_tasks)
      tasks_hash.each do |name, tasks|
        tasks.each { |task| task_send(name, task)}
      end
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def task_send(name, task)
      current_value = instance_variable_get("@#{name}".to_sym)
      meth = choose_action(task[:requirment])
      send(meth, name, current_value, task)
    end

    def choose_action(requirment)
      type = 
        case requirment
        when nil then 'presence'
        when Regexp then 'format'
        when Class then 'type'
        else raise ArgumentError
        end
      "validate_#{type}".to_sym
    end

    def validate_presence(name, value, _)
      return unless value.nil? || (value.respond_to?(:empty?) && value.empty?)
      raise RuntimeError, "#{name} is nil or empty (#{value})"
    end

    def validate_type(name, current_value, task)
      return if current_value.is_a? task[:requirment]
      raise "Class of this variable #{name} is #{current_value.class} and not #{task[:requirment]}"
    end

    def validate_format(name, current_value, task)
      return if current_value =~ task[:requirment]
      raise "Variable '#{name}' has wrong format"
    end

    # def validate!(*attribs)
    #   attribs.each do |attrib|
    #     self.class.validate_types.each do |type|  
    #       var_attrib = "@#{attrib}".to_sym
    #       var_type = "#{type}".to_sym
    #       puts "presence" if var_type == :presence
    #       raise "Unexisting object." unless self.class.var_type
    #     end
    #   end
    # end          

    # def valid?(attrib)      
    #   validate!
    #   true
    # rescue RuntimeError
    #   false
    # end

  end
end