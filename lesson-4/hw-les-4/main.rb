require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'




#Initialize objects

station1 = Station.new("Station1")
station2 = Station.new("Station2")
station3 = Station.new("Station3")
station4 = Station.new("Station4")
trains_on_station = []



train1 = PassengerTrain.new("train1")
train2 = PassengerTrain.new("train2")
train3 = CargoTrain.new("train3")
train4 = CargoTrain.new("train4")

route1 = Route.new(station1, station2)
route2 = Route.new(station1, station4)
route3 = Route.new(station1, station3)
stations_on_route = [station1.name, station2.name]

car1 = PassengerCar.new
car2 = PassengerCar.new
car3 = PassengerCar.new
car4 = PassengerCar.new
car5 = CargoCar.new
car6 = CargoCar.new
car7 = CargoCar.new
car8 = CargoCar.new


#Tests

#Test new train-car related methods
train1.add_car(car1)
train1.add_car(car2)
puts "Add"
puts train1.cars
train1.detach_car(car1)
puts "Delete"
puts train1.cars
train1.detach_car(car1)
puts "Delete"
puts train1.cars
train1.add_car(car2)
puts "Add"
puts train1.cars

#Test station methods
puts "Test station methods"
station1.train_arrival(train1)
trains_on_station << station1.trains.last.number
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_arrival(train2)
trains_on_station << station1.trains.last.number
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_arrival(train3)
trains_on_station << station1.trains.last.number
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_departure(train1)
trains_on_station.delete(train1.number)
puts "Currently there are several trains on the #{station1.name}: #{trains_on_station}"
station1.train_arrival(train4)
trains_on_station << station1.trains.last.number
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
puts Route.routes
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
=begin

#UI
puts "Greetings! Welcome to the program, which will help you to maintain your railway stations!"
puts "In this program you can manage your trains, your stations and your routes."
puts "Now you will be tranfered to the Main Menu."

exit_program = "start"
until exit_program == "exit"
puts "Please type in 'trains' for managing your trains, 'routes' for managing your routes or 'stations' to managing your stations."
user_input = gets.chomp.downcase
case user_input

when "trains"
  puts "You are now in the managing trains program section."
  puts "Here you can add new trains, assign route to train, add cars to train, detach them from train."
  puts "Also here you can move your train on the route."
  puts
  puts "Please type in 'add' to add the train, 'add route' to assign route to the train;"
  puts "type in 'move' to move train on his route or 'cars' to add or detach car from train."
  trains_input = gets.chomp.downcase
  case trains_input

  when "add"
    print "Currently there are several trains: "; Train.train_numbers    
    puts "Do you want to add passenger or cargo train?"
    train_type = gets.chomp.to_sym
    puts "Please type in number for your train to add."
    train_num = gets.chomp
    case train_type
    when :passenger    
      train = PassengerTrain.new(train_num)
    when :cargo
      train = CargoTrain.new(train_num)
    else
      train = PassengerTrain.new(train_num)
    end    
    puts "You've added #{train.number} train."
    print "Currently there are several trains: "; Train.train_numbers   

  when "add route"
    acceptable_train = false
    acceptable_route = false
    print "Currently there are several trains: "; Train.train_numbers    
    print "Currently there are several routes: "; Route.route_names    
    puts "Please type in train number and route name you want to assign to this train."
    puts "Please type in train number:"
    train_num = gets.chomp
    Train.trains.each do |train|
      if train.number == train_num
        train_num = train
        acceptable_train = true
      end
    end    
    puts "Please type in route name:"
    route_name = gets.chomp
    Route.routes.each do |route| 
      if route.name == route_name
        route_name = route 
        acceptable_route = true
      end
    end
    if acceptable_route && acceptable_train
      train_num.change_route(route_name) 
      puts "Train #{train_num.number} changed his route to #{route_name.name}."
    else
      puts "Unfortunately there is no such train or route."
    end

  when "move"
    acceptable_train = false
    puts "Please select train you want to move."
    print "Currently there are several trains: "; Train.train_numbers   
    puts "Please type in number of the train you want to move:"
    train_num = gets.chomp
    Train.trains.each do |train|
      if train.number == train_num && train.route
        train_num = train
        acceptable_train = true
      end
    end
    if acceptable_train
      puts "Type in 'forward' if you want to move your train forward or 'backward' if you want to move your train backward."
      direction = gets.chomp
      train_num.move_forward if direction == "forward"
      train_num.move_backward if direction == "backward"
    end

  when "cars"   
    acceptable_train = false
    puts "Please select train you want to operate with."
    print "Currently there are several trains: "; Train.train_numbers   
    puts "Please type in number of the train you want to operate with:"
    train_num = gets.chomp
    Train.trains.each do |train|
      if train.number == train_num
        train_num = train
        acceptable_train = true
      end
    end
    if acceptable_train
      puts "Type in 'add' to add the car to the train or 'detach' to detach it."
      action = gets.chomp
      case action
      when "add"              
        acceptable_car = false
        puts "Please select car to attach to the train."
        print "Currently there are several cars availible to attaching: "; Car.car_ids   
        puts "Please type in id of car you want to attach."
        car_id = gets.chomp.to_i
        Car.cars.each do |car|
          if car.car_id == car_id
            car_id = car
            acceptable_car = true
          end
        end
        if acceptable_car
          train_num.add_car(car_id)
        else
          puts "There is no car with this id number."
        end
      when "detach"
        acceptable_car = false
        puts "Please select car you want to detach."
        print "Currently there are several cars attached to the train: "
        train_num.cars.each do |car|
          print "#{car.car_id} "
        end
        puts
        puts "Please type in id of car you want to detach."
        car_id = gets.chomp.to_i
        train_num.cars.each do |car|
          if car.car_id == car_id
            car_id = car
            acceptable_car = true
          end
        end
        if acceptable_car
          train_num.detach_car(car_id) 
        else
          puts "There is no such car currently attched to train #{train.number}."
        end
      else
        puts "You've provided wrong type of input. Please try again."
      end
    end
  else 
    puts "You've provided wrong type of input. Please try again."
  end


when "routes"
  puts "You are now in the managing routes program section."
  puts "Here you can add new routes and add station to this route or delete them."
  puts
  puts "Please type in 'add' to add new route, 'add station' to add station to this route,"
  puts "or 'delete station' to delete station from this route."
  routes_input = gets.chomp.downcase
  case routes_input

  when "add"
    good_route = false
    good_station1 = false
    good_station2 = false
    print "Currently there are several routes: "; Route.route_names
    print "Currently there are several stations: "; Station.station_names    
    puts "Please type in name of the first station for the new route."
    first_station = gets.chomp
    Station.stations.each do |station|
      if station.name == first_station
        first_station = station 
        good_station1 = true
      end
    end
    puts "Please type in name of the last station for the new route."    
    last_staiton = gets.chomp
    Station.stations.each do |station| 
      if station.name == last_staiton
        last_staiton = station 
        good_station2 = true
      end
    end
    good_route = true unless first_station == last_staiton || good_station1 == false || good_station2 == false
    if good_route == true
      route = Route.new(first_station, last_staiton)
      puts "New route #{Route.routes.last.name} has been created."
    else
      puts "Unfortunately route has not been created."
    end
    print "Currently there are several routes: "; Route.route_names
  when "add station"
    print "Currently there are several routes: "; Route.route_names
    puts "Please type in route name you want to add station to."
    route_name = gets.chomp
    Route.routes.each {|route| route_name = route if route.name == route_name}
    print "Currently there are several stations: "; Station.station_names   
    puts "Please type in station name you want to add to this route."
    station_name = gets.chomp
    Station.stations.each {|station| station_name = station if station.name == station_name}
    route_name.add_station(station_name)
    puts "Station #{station_name.name} was successfully added to #{route_name.name}."
  when "delete station"
    print "Currently there are several routes: "; Route.route_names
    puts "Please type in route name you want to add station to."
    route_name = gets.chomp
    Route.routes.each {|route| route_name = route if route.name == route_name}
    print "Currently there are several station on route #{route_name.name}: "; route_name.station_names    
    puts "Please type in station you want to delete."
    station_name = gets.chomp
    Station.stations.each {|station| station_name = station if station.name == station_name}
    route_name.delete_station(station_name)
    puts "Unfortunately, you are unable to delete first or last station attached to route." if route_name.stations.length < 3
    print "Currently there are several station on route #{route_name.name}: "; route_name.station_names  
  else
    puts "You've provided wrong type of input. Please try again."
  end


when "stations"
  puts "Your are now in the managing stations program section."
  puts "Here you can add new stations or observe trains which are currently arrived on this station."
  puts "Please type in 'add' to add new station 'observe' to observe trains on station or 'list' to view list of existing stations."
  stations_input = gets.chomp.downcase
  case stations_input
  when "add"
    print "Currently there are several stations: "; Station.station_names    
    puts "Please type in name for your new station"
    station_name = gets.chomp
    station = Station.new(station_name)
    print "Currently there are several stations: "; Station.station_names    
  when "observe"
    print "Currently there are several stations: "; Station.station_names 
    puts "Please type in station you want to observe."
    station_name = gets.chomp
    Station.stations.each do |station| 
      if station.name == station_name
        station_name = station
        print "Currently there are several trains on station #{station_name.name}: "
        station.trains.each {|train| print "#{train.number} "}
      end  
    end
    puts

  when "list"
    print "Currently there are several stations: "; Station.station_names 
  else
    puts "You've provided wrong type of input. Please try again."
  end
else
  puts "You've provided wrong type of input. Please try again."
end


puts "Please type in 'exit' to exit the program."
exit_program = gets.chomp.downcase
end
=end