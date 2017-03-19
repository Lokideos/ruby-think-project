class Train    
  attr_reader :number, :type, :speed, :car_quantity

  def initialize(number, type, car_quantity)
    @number = number
    #[:passenger, :cargo].include? type
    if [:passenger, :cargo].include?(type)
      @type = type 
    else
      @type = :passenger
    end
    @car_quantity = car_quantity
    @speed = 0
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

  def add_car
    @car_quantity +=1 if @speed == 0
  end

  def detach_car
    @car_quantity -=1 if @car_quantity > 0 && @speed == 0
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