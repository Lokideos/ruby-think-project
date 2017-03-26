class Train    
  include Manufacturable 
  include InstanceCounter  

  attr_reader :number, :speed, :cars
  attr_accessor :route
  @@instances = {}

  def self.find(train_number)    
    @@instances[train_number.to_sym]
  end

  def initialize(number)   
    @number = number   
    @speed = 0
    @cars = []    
    @@instances[@number.to_sym] = self
    @manufacture = "Toshiba"   
    register_instance     
  end

  def speed_up(speed=10)
    @speed += speed    
  end  

  def speed_down(speed=10)
    @speed -= speed if @speed > 0    
  end

  def speed_stop 
    @speed = 0
  end  

  def add_car(car)    
    @cars << car if speed == 0 && correct_car?(car)
  end

  def detach_car(car)
    @cars.delete(car) if @speed == 0  
  end 

  def correct_car?(car)
    car_has_correct_type = true
  end

  def change_route(route)
    @route = route
    @route_position = 0    
  end

  def last_position?
    @route_position == @route.stations.length-1
  end

  def first_position?
    @route_position == 0
  end

  def move_forward
    if next_station
      @route_position += 1 
      current_station.train_arrival(self)
      previous_station.train_departure(self)
    end
  end

  def move_backward
    if previous_station
      @route_position -= 1 
      current_station.train_arrival(self)
      next_station.train_departure(self)
    end
  end

  def previous_station  
    @route.stations[@route_position-1] unless first_position?   
  end

  def current_station
    @route.stations[@route_position] 
  end

  def next_station
    @route.stations[@route_position+1] unless last_position?  
  end  
  
end