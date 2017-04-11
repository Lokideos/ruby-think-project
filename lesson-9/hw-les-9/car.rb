class Car
  include Manufacturable
  include Validation

  attr_reader :car_id
  alias id car_id

  validate :car_id, :presence

  def initialize(_attrib)
    validate!
    @car_id = object_id.to_s
    @manufacture = 'Toshiba'
  end
end
