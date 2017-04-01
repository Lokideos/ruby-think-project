class Car
  include Manufacturable  
  attr_reader :car_id  

  def initialize(attrib)
    validate!
    @car_id = "#{object_id}"
    @manufacture = "Toshiba"
  end  

  def valid?    
    validate!
    true
    rescue RuntimeError
      false
  end

  private

  def validate!
    raise "Unexisting car type" unless self.is_a?(CargoCar) || self.is_a?(PassengerCar)
  end
end