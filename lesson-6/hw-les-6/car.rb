class Car
  include Manufacturable  
  attr_reader :car_id  

  def initialize
    @car_id = "#{object_id}"
    @manufacture = "Toshiba"
  end  
end