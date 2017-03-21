require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'tests'
require_relative 'application'

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

#Tests.run
puts "Greetings! Welcome to the program, which will help you to maintain your railway stations!"
puts "In this program you can manage your trains, your stations and your routes."
puts "Now you will be tranfered to the Main Menu."

exit_program = "start"
until exit_program == "exit"
  Application.run

  puts "Please type in 'exit' to exit the program."
  exit_program = gets.chomp.downcase
end