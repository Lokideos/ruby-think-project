require_relative 'station'
require_relative 'route'
require_relative 'train'

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