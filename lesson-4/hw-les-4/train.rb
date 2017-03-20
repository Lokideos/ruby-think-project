class Train    
  attr_reader :number, :speed, :type, :cars
  attr_accessor :route
  @@trains=[]

  def initialize(number)
    @type = :default
    @number = number   
    @speed = 0
    @cars = []
    @@trains << self
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
    if car.type == @type && speed == 0
      adding_car = true
      @cars.each {|car_on_train| adding_car = false if car_on_train.car_id == car.car_id}
      if adding_car == true
        @cars << car 
        car.attached = true
      end
    end
  end

  def detach_car(car)
    @cars.delete(car) if @speed == 0
    car.attached = false
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

  def self.trains
    @@trains
  end

  def self.train_numbers
    @@trains.each {|train| print " #{train.number}"}
    puts
    puts
  end

end