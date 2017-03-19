require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'

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
    puts "Currently there are #{Train.show_trains} trains."
    puts "Please type in number for your train to add."
    train_num = gets.chomp.to_i
    train = Train.new(train_num)
    puts "You've added #{train} train."
    puts "Currently there are #{Train.show_trains} trains."
  when "add route"
    puts "Currently there are #{Train.show_trains} trains and #{Route.show_routes} routes."
    puts "Please type in train number and route name you want to assign to this train."
    puts "Please type in train number."
    train_num = gets.chomp.to_i
    puts "There is no train with this number" unless Train.show_trains.each {|train| train.number == train_num}
    puts "Please type in route name."
    route_name = gets.chomp
    puts "There is no route with this route name" unless Route.show_routes.include?(route_name)

    #finish car and other train methods

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
    puts "There are currently #{Route.show_stations} routes."
    puts "There are currently #{Station.show_stations} stations."
    puts "Please type in name of the first station for the new route."
    first_station = gets.chomp
    Station.show_stations.each {|station| first_station = station if station.name == first_station}
    puts "Please type in name of the last station for the new route."    
    last_staiton = gets.chomp
    Station.show_stations.each {|station| last_staiton = station if station.name == last_staiton && first_station != last_staiton}
    good_route = true unless first_station == last_staiton
    if good_route
      route = Route.new(first_station, last_staiton)
      puts "New route has been created."
    end
    puts "There are currently #{Route.show_stations} routes."
  when "add station"
    puts "There are currently #{Route.show_stations} routes."
    puts "Please type in route name you want to add station to."
    route_name = gets.chomp
    Route.show_routes.each {|route| route_name = route if route.name == route_name}
    puts "There are currently #{Station.show_stations} stations."
    puts "Please type in station name you want to add to this route."
    station_name = gets.chomp
    Station.show_stations.each {|station| station_name = station if station.name == station_name}
    route_name.add_station(station_name)
  when "delete station"
    puts "There are currently #{Route.show_stations} routes."
    puts "Please type in route name you want to add station to."
    route_name = gets.chomp
    Route.show_routes.each {|route| route_name = route if route.name == route_name}
    puts "There are currently #{route_name.stations}stations on this route."
    puts "Please type in station you want to delete."
    station_name = gets.chomp
    route_name.delete_station(station_name)
  else
    puts "You've provided wrong type of input. Please try again."
  end
when "stations"
  puts "Your are now in the managing stations program section."
  puts "Here you can add new stations or observe trains which are currently arrived on this station."
  puts "Please type in 'add' to add new station or 'observe' to observe trains on station."
  stations_input = gets.chomp.downcase
  case stations_input
  when "add"
    puts "Currently there are #{Station.show_stations} stations."
    puts "Please type in name for your new station"
    station_name = gets.chomp
    station = Station.new(station_name)
    puts "Currently there are #{Station.show_stations} stations."
  when "observe"
    puts "Please type in station you want to observe."
    station_name = gets.chomp
    Station.show_stations.each {|station| puts stations.show_trains if station.name == station_name}
  else
    puts "You've provided wrong type of input. Please try again."
  end
else
  puts "You've provided wrong type of input. Please try again."
end




puts "Please type in 'exit' to exit the program."
exit_program = gets.chomp.downcase
end
puts "Press any key to exit the program..."
gets.chomp

#test data to replenish
=begin
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
=end