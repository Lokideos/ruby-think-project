require_relative 'manufacturable.rb'
require_relative 'instance_counter.rb'
require_relative 'train.rb'
require_relative 'station.rb'

#Tests
class Tests
#Test new train-car related methods
  
  def run
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
    arr = station1.trains_by_type("PassengerTrain")
    arr.each {|train| puts train.number}
    puts
    puts "Cargo trains:"
    arr = station1.trains_by_type("CargoTrain")
    arr.each {|train| puts train.number}
    puts

    #Test route methods
    puts "Test Route methods"
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
  end

  def test_instances_and_stations
    Train.new("t1")
    Train.new("t2")
    Train.new("t3")
    Train.new("t4")
    Train.new("t5")
    Station.new("s1")
    Station.new("s2")
    puts Station.all
    puts Train.find("t3").manufacture
    #5.times {Train.new("t1")}    
    puts Train.instances
  end
end

test1 = Tests.new

test1.test_instances_and_stations