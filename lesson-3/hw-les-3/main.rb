class Station
  attr_reader :name  

  def initialize (name)
    @name = name
    @trains = []
  end

  def train_arrival(train)
    @trains << train    
  end

  def show_trains
    @trains
  end

  def trains_by_type (train_type)    
    @trains.select {|train| train.type == train_type}    
  end

  def train_departure(train)
    @trains.delete (train) {"There is no such train."}
  end
end

class Route
  @@routes = [] #For testing purposes
  @@route_name_counter = 0 #For testing purposes
  attr_reader :stations, :name
  

  def initialize (first_station, last_station)    
    @stations = [first_station, last_station] if first_station != last_station  #should be instances of Station class
    @@route_name_counter +=1 #For testing purposes
    @name = "route #{@@route_name_counter}"
    @@routes << @name #For testing purposes
  end

  def add_station(station)    
    @stations.insert(-2, station)
  end

  def delete_station (station)
    @stations.delete(station) if ![@stations.first, @stations.last].include?(station)
  end

  #For testing purposes
  def self.show_routes
    @@routes
  end
end

class Train    
  attr_reader :number, :type, :speed, :car_quantity

  def initialize(number, type, car_quantity)
    @number = number
    #[:passenger, :cargo].include? type
    if [:passenger, :cargo].include? type    
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
    @chosen_route = route
    @route_position = 0    
  end

  def is_not_last?
    @route_position < @chosen_route.stations.length-1
  end

  def move_forward
    if !(self.next_station.nil?)
      @route_position += 1 
      self.current_station.train_arrival(self)
      self.previous_station.train_departure(self)
    end
  end

  def move_backward
    if !(self.previous_station.nil?)
      @route_position -= 1 
      self.current_station.train_arrival(self)
      self.next_station.train_departure(self)
    end
  end

  def previous_station  
    @chosen_route.stations[@route_position-1] if @route_position > 0    
  end

  def current_station
    @chosen_route.stations[@route_position] 
  end

  def next_station
    @chosen_route.stations[@route_position+1] if is_not_last?  
  end  
end


#Initialize objects
station1 = Station.new("Aleksandrovskaya1")
station2 = Station.new("Bogoslovskaya2")
station3 = Station.new("Whatever3")
station4 = Station.new("Stop_it_please4")
trains_on_station = []

train1 = Train.new("train1", :passenger, 8)
train2 = Train.new("train2", 4, 4)
train3 = Train.new("train3", :cargo, 14)
train4 = Train.new("train4", :cargo, 10)

route1 = Route.new(station1, station2)
route2 = Route.new(station1, station4)
route3 = Route.new(station1, station3)
stations_on_route = [station1.name, station2.name]

#Test station methods
puts "Test station methods"
station1.train_arrival(train1)
trains_on_station << station1.show_trains.last.number
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_arrival(train2)
trains_on_station << station1.show_trains.last.number
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_arrival(train3)
trains_on_station << station1.show_trains.last.number
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_departure(train1)
trains_on_station.delete(train1.number)
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_arrival(train4)
trains_on_station << station1.show_trains.last.number
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
puts "Passenger trains:"
arr = station1.trains_by_type(:passenger)
arr.each {|train| puts train.number}
puts
puts "Cargo trains:"
arr = station1.trains_by_type(:cargo)
arr.each {|train| puts train.number}
puts

#Test route methods
puts "Test Route methods"
puts Route.show_routes
puts route1.stations
puts "Currently there are #{stations_on_route} on the #{route1.name}"
route1.add_station(station3)
stations_on_route.insert(-2, station3.name)
puts route1.stations
puts "Currently there are #{stations_on_route} on the #{route1.name}"
route1.delete_station(station3)
puts route1.stations
stations_on_route.delete(station3.name) if ![stations_on_route.first, stations_on_route.last].include? (station3.name)
puts "Currently there are #{stations_on_route} on the #{route1.name}"
route1.add_station(station4)
puts route1.stations
stations_on_route.insert(-2, station4.name)
puts "Currently there are #{stations_on_route} on the #{route1.name}"
puts

#Test Train methods
puts "Test Train methods"
puts "Currently there are #{train1.car_quantity} cars."
puts train1.add_car
puts train1.detach_car

puts "Current speed is #{train1.speed}"
puts train1.speed_up
puts train1.speed_stop
puts "Current speed is #{train1.speed}"
puts train1.speed_down
puts "Current speed is #{train1.speed}"
train1.change_route(route1)



puts train1.previous_station
puts "There is no previous_station" if train1.previous_station.nil?
puts train1.current_station
puts train1.next_station
puts
train1.move_forward
puts train1.previous_station
puts "There is no previous_station" if train1.previous_station.nil?
puts train1.current_station
puts train1.next_station
puts "There is no next station" if train1.next_station.nil?
puts
train1.move_backward
puts train1.previous_station
puts "There is no previous_station" if train1.previous_station.nil?
puts train1.current_station
puts train1.next_station
puts "There is no next station" if train1.next_station.nil?
puts
train1.move_forward
train1.move_forward
puts train1.previous_station
puts train1.current_station
puts train1.next_station
puts "There is no next station" if train1.next_station.nil?
puts
train1.move_forward
puts train1.previous_station
puts train1.current_station
puts train1.next_station
puts "There is no next station" if train1.next_station.nil?