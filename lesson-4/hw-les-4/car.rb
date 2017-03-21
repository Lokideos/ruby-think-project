class Car
  
  attr_reader :car_id  

  def initialize
    @car_id = "#{object_id}"
  end
  
end