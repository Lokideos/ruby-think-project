require_relative 'accessors'
require_relative 'validation'
# require_relative 'manufacturable'
# require_relative 'instance_counter'
# require_relative 'station'
# require_relative 'route'
# require_relative 'train'
# require_relative 'passenger_train'
# require_relative 'cargo_train'
# require_relative 'car'
# require_relative 'cargo_car'
# require_relative 'passenger_car'
# require_relative 'ui'
# require_relative 'application'

class Test
  include Accessors
  include Validation

  attr_accessor_with_history :a
  strong_attr_accessor :b, :string
  strong_attr_accessor :c, :fixnum
  validate :a, :presence
  validate :a, :format, /[0-9]{1}/
  validate :a, :type, Integer
end
