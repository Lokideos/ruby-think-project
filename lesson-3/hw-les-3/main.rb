class Station
  attr_reader :name

  def initialize (name)
    @name = name
    @trains_on_station = []
  end

  def train_arrival(train)
    @trains_on_station << train if train.speed == 0
    puts "Please decrease speed of your train to arrive on the staiton" if train.speed != 0
  end

  def show_trains
    @trains_on_station.each do |train|
      print "#{train.number} "
    end
    puts
  end

  def show_trains_type
    print "Thre are several passenger trains on the station: "
    @trains_on_station.each do |train|
      print "#{train.number} " if train.type == "passenger"
    end
    puts
    print "Thre are several cargo trains on the station: "
    @trains_on_station.each do |train|
      print "#{train.number} " if train.type == "cargo"
    end
    puts
  end

  def train_departure(train)
    @trains_on_station.each_with_index do |t, index|
      @trains_on_station.delete_at(index) if @trains_on_station[index] == train
    end      
  end
end

class Route
  @@routes = []
  @@route_name_counter = 0
  attr_accessor :stations,:name
  

  def initialize (first_station, last_station)    
    self.stations = [first_station, last_station] if first_station != last_station  #should be instances of Station class
    @@route_name_counter +=1    
    @name = "route #{@@route_name_counter}"
    @@routes << @name
  end

  def add_station(station_name)
    self.stations << self.stations.last
    self.stations[-2] = station_name    
  end

  def delete_station (station_name)
    self.stations.each.with_index do |station, index| 
      station = station_name
      self.stations.delete_at(index) if self.stations[index] == station && station != self.stations[0] && station != self.stations[-1]
    end
  end

  def show_stations
    print "Currently there are several stations on #{self.name} route: "
    self.stations.each.with_index do |station|
      print "#{station.name} "
    end
    puts
  end

  def self.show_routes
    puts "Currently there are #{@@routes} routes."
  end
end

class Train  
  attr_accessor :car_quantity
  attr_reader :number, :type, :speed  

  def initialize(number, type = "passenger", car_quantity)
    @number = number
    @type = type if type == "passenger" || type == "cargo"
    self.car_quantity = car_quantity
    @speed = 0
  end

  def speed_up(speed=10)
    @speed += speed
    puts "Acceleration of speed by #{speed} m/h."    
  end

  def current_speed
    puts "Current train's speed is #{self.speed} m/h."
  end

  def speed_down(speed=10)
    @speed -= speed
    puts "Deceleration of speed by #{speed} m/h."    
  end

  def show_cars
    puts "Currently there are #{@car_quantity} cars connected to the train."
  end

  def change_cars_quantity
    puts "Do you want to add one car or to remove one?"
    puts "Type in 'add' to add 1 car or 'remove' to remove 1 car."
    user_choice = gets.chomp.downcase
    if user_choice == "add"
      self.car_quantity +=1
    elsif user_choice == "remove"
      self.car_quantity -=1
    end
  end

  def change_route(route)
    @chosen_route = route
    @route_position = 0    
  end

  def move_on_route
    puts "Do you want to move forward or backward?"
    user_choice = gets.chomp
    if user_choice == "forward"
      @route_position += 1 if @route_position < @chosen_route.stations.length-1      
    elsif user_choice == "backward"
      @route_position -= 1 if @route_position > 0
    end
    @chosen_route.stations[@route_position].train_arrival(self)
  end

  def show_station_neighbors
    case @route_position
    when 0
      puts "Current station is #{@chosen_route.stations[@route_position].name}"
      puts "Next station is #{@chosen_route.stations[@route_position+1].name}"
    when @chosen_route.stations.length-1
      puts "Previous station is #{@chosen_route.stations[@route_position-1].name}"
      puts "Current station is #{@chosen_route.stations[@route_position].name}"
    else
      puts "Previous station is #{@chosen_route.stations[@route_position-1].name}"
      puts "Current station is #{@chosen_route.stations[@route_position].name}"
      puts "Next station is #{@chosen_route.stations[@route_position+1].name}"
    end

  end
end

#Initialize objects
station1 = Station.new("Aleksandrovskaya1")
station2 = Station.new("Bogoslovskaya2")
station3 = Station.new("Whatever3")
station4 = Station.new("Stop_it_please4")

train1 = Train.new("train1", "passanger", 8)
train2 = Train.new("train2", "passanger", 4)
train3 = Train.new("train3", "cargo", 14)
train4 = Train.new("train4", "cargo", 10)

route1 = Route.new(station1, station2)
route2 = Route.new(station1, station4)
route3 = Route.new(station1, station3)

#Test station methods
puts "Test station methods"
station1.train_arrival(train1)
station1.show_trains
station1.train_arrival(train2)
station1.show_trains
station1.train_arrival(train3)
station1.show_trains
station1.train_departure(train1)
station1.train_arrival(train4)
station1.show_trains
station1.show_trains_type
puts

#Test route methods
puts "Test Route methods"
Route.show_routes
route1.show_stations
route1.add_station(station3)
route1.show_stations
route1.delete_station(station3)
route1.show_stations
route1.add_station(station4)
route1.show_stations
puts

#Test Train methods
puts "Test Train methods"
train1.show_cars

train1.change_cars_quantity
train1.show_cars
train1.change_cars_quantity
train1.show_cars

train1.current_speed
train1.speed_up
train1.current_speed
train1.speed_down
train1.current_speed
train1.change_route(route1)
train1.show_station_neighbors
train1.move_on_route
train1.show_station_neighbors
train1.move_on_route
train1.show_station_neighbors