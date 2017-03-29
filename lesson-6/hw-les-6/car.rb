class Car
  include Manufacturable  
  attr_reader :car_id  

  def initialize(car_type)
    raise unless valid?(car_type)    
    @car_id = "#{object_id}"
    @manufacture = "Toshiba"
  end  

  private

  def valid? (cargo_type)
  raise "Unexisting car type" unless cargo_type == "cargo" || cargo_type == "passenger"
    true
  end
end