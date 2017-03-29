class Car
  include Manufacturable  
  include Validable
  attr_reader :car_id  

  def initialize(car_type="default")
    raise unless valid?(:car_add, car_type)    
    @car_id = "#{object_id}"
    @manufacture = "Toshiba"
  end  
end