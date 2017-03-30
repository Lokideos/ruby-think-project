class Car
  include Manufacturable  
  attr_reader :car_id  

  def initialize
    validate!
    @car_id = "#{object_id}"
    @manufacture = "Toshiba"
  end  

  def valid?    
    validate!
    true
    rescue
      false
  end

  private

  def validate!
    raise "Unexisting car type" unless self.is_a?(CargoCar) || self.is_a?(PassengerCar)
  end
end