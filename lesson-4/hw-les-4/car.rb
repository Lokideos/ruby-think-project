class Car
  
  attr_accessor :attached
  attr_reader :car_id  

  def initialize
    @car_id = object_id    
    self.attached = false   
    
  end
  
end