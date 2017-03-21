require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'addable'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'tests'
require_relative 'application'

#test1 = Tests.new
#test1.run

puts "Greetings! Welcome to the program, which will help you to maintain your railway stations!"
puts "In this program you can manage your trains, your stations and your routes."
puts "Now you will be tranfered to the Main Menu."

start = Application.new
start.run
