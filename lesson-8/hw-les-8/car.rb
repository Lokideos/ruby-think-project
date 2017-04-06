class Car
  include Manufacturable
  attr_reader :car_id
  alias id car_id

  def initialize(_attrib)
    validate!
    @car_id = object_id.to_s
    @manufacture = 'Toshiba'
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  private

  def validate!
    raise 'Unexisting car type' unless is_a?(CargoCar) || is_a?(PassengerCar)
  end
end
