class Car
  include Manufacturable  
  attr_reader :car_id  

  def initialize
    validate!
    @car_id = "#{object_id}"
    @manufacture = "Toshiba"
  end  

  def valid?    
    valid = true
    valid = false unless self.is_a?(CargoCar) || self.is_a?(PassengerCar)
    valid    
  end

  private

  def validate!
  raise "Unexisting car type" unless self.is_a?(CargoCar) || self.is_a?(PassengerCar)
  end
end