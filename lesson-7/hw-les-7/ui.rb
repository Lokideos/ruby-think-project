class UI

  attr_reader :user_input1, :user_input2

  def initialize
    @user_input1 = ""
    @user_input2 = ""
  end

  def input_1_change
    @user_input1 = gets.chomp
  end

  def input_2_change
    @user_input2 = gets.chomp
  end

  def main_msg
    puts "Greetings! Welcome to the program, which will help you to maintain your railway stations!"
    puts "In this program you can manage your trains, your stations and your routes."
    puts "Now you will be tranfered to the Main Menu."
  end

  def run_msg
    puts "Please type in 'trains' for managing your trains, 'routes' for managing your routes, 'stations' to managing your stations or 'cars' to add or delete cars."
  end

  def run_exit_msg
    puts "Please type in 'exit' to exit the program."
  end


  def manage_trains_selected_msg
    puts "You are now in the managing trains program section."
    puts "Here you can add new trains, assign route to train, add cars to train, detach them from train."
    puts "Also here you can move your train on the route."
    puts
    puts "Please type in 'add' to add the train, 'add route' to assign route to the train;"
    puts "type in 'move' to move train on his route or 'cars' to add or detach car from train"
    puts "Also you can type in 'observe' to see cars attached to chosen train."
  end

  def manage_trains_add_route_msg(trains, routes)
    print "Currently there are several trains: "; puts trains_numbers(trains); puts
    puts
    print "Currently there are several routes: "; puts print_names(routes); puts
    puts
    puts "Please type in train number and route name you want to assign to this train in the respectful order:"
  end

  def manage_trains_add_selected_trains_show_msg(trains)
    print "Currently there are several trains: "; puts trains_numbers(trains); puts
    puts "Please type in train's type and train number in the respectful order."    
    puts "Train's type should be 'passenger' or 'cargo'"
  end

  def create_train_failed_msg
    puts "Unfortunately train with this number already exists."
  end

  def manage_trains_add_train_add_success_msg(train)
    puts "You've added #{train.number} train."
  end

  def manage_routes_msg
    puts "You are now in the managing routes program section."
    puts "Here you can add new routes and add station to this route or delete them."
    puts
    puts "Please type in 'add' to add new route, 'add station' to add station to this route,"
    puts "or 'delete station' to delete station from this route."
  end

  def manage_trains_move_msg(trains)
    puts "Please select train you want to move."
    print "Currently there are several trains: "; puts trains_numbers(trains); puts
    puts   
    puts "Please type in number of the train you want to move:"
  end

  def change_route_good_route_msg(train, route)
    puts "Train #{train.number} changed his route to #{route.name}."
  end

  def change_route_bad_route_msg
    puts "Unfortunately there is no such train or route."
  end

  def train_move_on_route_direction_msg
    puts "Type in 'forward' if you want to move your train forward or 'backward' if you want to move your train backward."
  end

  def train_move_on_route_bad_msg
    puts "Unfortunately train with this number does not exists." 
  end

  def manage_trains_cars_msg(trains)
    puts "Please select train you want to operate with."
    print "Currently there are several trains: "; puts trains_numbers(trains); puts           
    puts "Please type in number of the train you want to operate with:"
  end

  def add_correct_car_action_msg
    puts "Type in 'add' to add the car to the train, 'detach' to detach it or 'occupy' to take seat or add cargo to one of the cars."
  end

  def manage_trains_cars_add_msg(cars_free)
    puts "Please select car to attach to the train."
    print "Currently there are several cars availible to attaching: "; puts print_car_ids(cars_free); puts
    puts "Please type in id of car you want to attach."
  end

  def manage_trains_cars_add_type_mismatch_msg
    puts "Unfortunately car's type and train's type are different."
  end

  def manage_trains_cars_add_existance_car_error_msg(train)
    puts "There is no such car currently attched to train #{train.number}."
  end

  def manage_trains_cars_add_success_msg(train, car)
    puts "Car #{car.car_id} was successfully added to train #{train.number}."
  end

  def manage_trains_cars_add_error_msg
    puts "There is no car with this id number."
  end

  def cars_attached_to_train_msg(train)
    puts "Please select car you want to detach."
    print "Currently there are several cars attached to the train: "    
    train.cars.each { |car| print "#{car.car_id} "}    
    puts
    puts "Please type in id of car you want to detach."
  end

  def manage_trains_cars_detach_success_msg(train, car)
    puts "Car #{car.car_id} was successfully detached from train #{train.number}."
  end

  def manage_cars_choose_car_msg(cars)
    print "Currently there are several cars: "; puts print_car_ids(cars); puts 
  end

  def manage_trains_occupy_success_cargo_msg(car)
    puts "Cargo has been succesfully loaded to car number #{car.car_id}."
    puts "There're still #{car.current_volume} free space for this car." 
  end

  def manage_trains_occupy_success_passenger_msg(car)
    puts "Passenger has successfully taken the seat on car number #{car.car_id}."
    puts "There're still #{car.current_seats} free seats on this car."
  end

  def manage_trains_choose_train_msg(trains)
    puts "Please select train you want to operate with."
    print "Currently there are several trains: "; puts trains_numbers(trains); puts
    puts "Type in number of needed train:"
  end

  def manage_routes_add_route_msg (routes, stations)
    print "Currently there are several routes: "; puts print_names(routes); puts
    print "Currently there are several stations: "; puts print_names(stations); puts  
  end

  def manage_routes_add_route_input_msg
    puts "Please type in name of the first and last stations for the new route in the respectful order:"    
  end

  def manage_routes_add_route_success_msg(route)
    puts "New route #{route.name} has been sucessfully created."
  end

  def manage_routes_add_station_msg(routes, stations)
    print "Currently there are several routes: "; puts print_names(routes); puts
    print "Currently there are several stations: "; puts print_names(stations); puts
  end

  def manage_routes_add_station_input_msg
    puts "Please type in route name you want to add station to and station name you want to add to the route."
    puts "Pleae do so in the respectful order:"
  end

  def manage_routes_add_station_success_msg(station, route)
    puts "Station #{station.name} was successfully added to #{route.name}."
  end 

  def manage_routes_delete_station_msg(routes, stations)
    print "Currently there are several routes: "; puts print_names(routes); puts
    print "Currently there are several stations: "; puts print_names(stations); puts  
  end

  def manage_routes_delete_station_input_route_msg
    puts "Please type in route name you want to delete station from."    
  end

  def manage_routes_delete_station_input_station_msg(route)
    print "Currently there are several stations on route #{route.name}: "; puts route.stations_names; puts 
    puts "Please type in station name you want to delete."
  end

  def manage_routes_delete_station_success_msg(station, route)
    puts "Station #{station.name} has been succesfully removed from route #{route.name}."
  end

  def manage_stations_msg
    puts "Your are now in the managing stations program section."
    puts "Here you can add new stations or observe trains which are currently arrived on this station."
    puts "Please type in 'add' to add new station 'observe' to observe trains on station or 'list' to view list of existing stations."
    puts "Also you can type in 'trains' to observe trains attached to the chosen station."
  end

  def manage_stations_choose_station_msg(stations)
    print "Currently there are several stations: "; puts print_names(stations); puts
    puts "Please type in station's name you want to observe:"
  end

  def manage_stations_add_station_msg(stations)
    print "Currently there are several stations: "; puts print_names(stations); puts
  end

  def manage_stations_add_station_input_msg
    puts "Please type in name for your new station"
  end

  def manage_stations_add_station_success_msg(station)
    puts "Station #{station.name} has been succesfully added."
  end

  def manage_stations_observe_station_msg(stations)
    print "Currently there are several stations: "; puts print_names(stations); puts
    puts "Please type in station you want to observe."
  end

  def manage_stations_observe_station_observe_msg(station)
    print "Currently there are several trains on station #{station_name.name}: "
    station.trains.each {|train| print "#{train.number} "}
    puts
  end

  def manage_cars_msg
    puts "Here you can manage your cars by addding new cars or deleting cars."
    puts "Please type in 'add' to add cars or 'remove' to remove cars:"
  end

  def manage_cars_add_car_msg(cars)
    print "Currently there are several cars: "; puts print_car_ids(cars); puts
    puts "Do you want to add passenger or cargo car?"
  end

  def manage_cars_add_car_input_msg
    puts "Type in 'cargo' to add cargo car or 'passenger' to add passenger car:" 
  end

  def manage_cars_add_car_input_volume_msg 
    puts "Type in volume in m^3 for your cargo car."
  end

  def manage_cars_add_car_input_seats_msg 
    puts "Type in seats quantity for your passenger car."
  end

  def manage_cars_add_car_success_msg(car)
    puts "#{car.class.to_s.capitalize} car #{car.object_id} was succesfully added."
  end

  def manage_cars_remove_car_msg(cars)
    print "Currently there are several cars: "; puts print_car_ids(cars); puts 
  end

  def manage_cars_remove_car_input_msg
    puts "Please type in car id of car you want to delete:"
  end

  def manage_cars_remove_car_success_msg
    puts "Car was sucessfully deleted."
  end  

  def wrong_input_msg
    puts "You've provided wrong type of input. Please try again."   
  end

  def print_names (objects)
    names = []
    objects.each {|object| names << object.name}
    names
  end

  def trains_numbers(trains)
    train_numbers = []
    trains.each {|train| train_numbers << train.number}
    train_numbers
  end

  def print_car_ids (cars)
    car_ids = []
    cars.each {|car| car_ids << car.car_id}
    car_ids
  end

  private

  attr_writer :user_input1, :user_input2

end